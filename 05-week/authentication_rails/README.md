#Authentication with Rails, Pt. II

##Learning Objectives
* Build sign up & login functionality

##Roadmap
Now that we've got passwords and a secure, encrypted way to check if a user is who they say they are, all we have to do is build out our interface to do it.

This involves two pieces: signing up for an account and then authenticating and logging in as a particular user.

##Signing Up
The beauty of "signing up" as a user is that there's nothing at all magical about it – it's literally just creating an instance of a user in our database.

Just like any other model, we need the C of our CRUD. You can fill in the rest later, but we'll do this part together.

And just like all our other Rails applications, we only need to build a few things:

- **Routes**
- **Model**
- **View**
- **Controller**

We've already got our model, so that's one down.

###Routes
Let's start by adding a few routes:

```ruby
# config/routes.rb
get "users" => "users#index"
post "users" => "users#create"
```

Perfect. Now, let's add a special one for the user's new page. It's not just any new page, it's a _signup_ page. Since we want people to _sign up_, let's send them to a path called "signup"!

```ruby
# config/routes.rb
get "signup" => "users#new"
```

With our routes out of the way, let's build our Users Controller.

###Controller
Let's generate a controller:

```bash
$ rails g controller users
```

Open up your new ``UsersController``, and we'll add our ``index``, ``new``, and ``create`` actions.  We've done this with a lot of controllers, so let's just fill it out like we normally would, with common Rails conventions. Don't forget our params method!

```ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

```

Notice that we're permitting a param called `:password` – remember, even though that won't be stored, that's how we set up our model in the first authentication lesson. That password will get encrypted and stored as `password_digest`, but password is what we wrote the setter method for.

Super. Last up are our views!

###Views
We've only got two views to make – our ``index`` and our ``new``.

Our index has nothing to do with signing up, it's just so we have something to look at and know creating a user instance worked. Let's quickly list out the users in our database. 

```html
<!-- app/views/users/index.html.erb -->
<h1>Users</h1>
<ul>
  <% @users.each do |user| %>
    <li><%= user.name %></li>
  <% end %>
</ul>
```

Just to make sure that works, let's spin up our Rails server and cruise over to `localhost:3000/users`. Did it work?  Hell yes it did--boom!

Now, the fun part – our sign up page. Remember, this is nothing more than a form to create a new instance of our User model.

```html
<!-- app/views/users/new.html.erb -->
<h1>Sign Up</h1>
<%= form_for @user do |f| %>
  <div>
    <%= f.label :name %>
    <%= f.text_field :name %>
  </div>
  <div>
    <%= f.label :email %>
    <%= f.text_field :email %>
  </div>
  <div>
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div>
    <%= f.submit %>
  </div>
<% end %>
```

You might not have encountered that ``password_field`` before – it's just like a ``text_field``, but it hides what you're typing. You know, for security ;)

Now, because of that awesome setup we built where ``password`` gets encrypted and not saved, if you check out your database, you'll notice we just made a new user, with a securely encrypted password.

**And that's all signing up is.**

##Logging In
Now that we're this far, we definitely want to build something out so someone can _log in._

**What do we mean by log in?** All that means is that after we've proven we are who we say we are – we want our local computer to _remember_ who we are.

For as long as our browser is open, it will remember that we are an authenticated user. We'll call that a session. The way the browser remembers who we are is by storing a tiny little text file on our hard drive called a **cookie.**

Rails makes all of this extremely easy. We just have to make a controller that can create a new session (log in), and destroy an existing session (log out).

This will be a little different than our other controllers, because this one won't be backed by a _model_ – we don't need it. Even though we don't need a model to manage our sessions, we will still need:

- **Routes**
- **Controller**
- **View**

###Routes

In our routes file, we'll add three more routes: 

```ruby
# config/routes.rb
get '/login'     => 'sessions#new'
post '/login'    => 'sessions#create'
delete '/logout' => 'sessions#destroy'
```

###Creating a SessionsController
We're going to need a controller!

```
rails g controller sessions
```

Let's start by adding three actions to our Sessions Controller. We could probably figure out by looking at the routes we just wrote which controller actions we need to define:

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
  end
end
```

Our ``new`` method doesn't need anything inside it. The only thing we are going to use it for is to render a view template that has a login form.

###The New Session (a.k.a Login) Form

In our view, we're going to make a form that's not  backed by a _model_:

```html
<!-- app/views/sessions/new.html.erb -->
<h1>Log In</h1>
<%= form_for :login do |f| %>
  <div>
    <%= f.label :email %>
    <%= f.text_field :email %>
  </div>
  <div>
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div>
    <%= f.submit 'Log In' %>
  </div>
<% end %>
```

If you look at the rendered HTML when you view source on the browser page, you'll see something like this:

```html
<form accept-charset="UTF-8" action="/login" method="post">
  <div>
    <label for="login_email">Email</label>
    <input id="login_email" name="login[email]" type="text">
  </div>
  <div>
    <label for="login_password">Password</label>
    <input id="login_password" name="login[password]" type="password">
  </div>
  <div>
    <input name="commit" type="submit" value="Log In">
  </div>
</form>
```

Rails infers that based on the routes we've set up that we want to POST information to `/login`.

Our params will come through like this, because of how we made that form:

```ruby
{
  "login" => {
    "email" => 'something@whatever.com',
    "password" => 'someplaintext'
  }
}
```

###Creating a 'Session'
Now that we have our form with a user's email address being sent to us in the params, we can query our database to find the user record that has that email:

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])
  end

  def destroy
  end
end
```

And if that works, and if we find a user, we can check whether their encyrpted password is the same as the one they just gave us.

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])
    if user && user.authenticate(params[:login][:password])
      # set a cookie, so our browser knows 
      # we are who we say we are
    else
      # give them another shot at logging
      # perhaps by redirecting back to the login form
    end
  end

  def destroy
  end
end
```

Now we just need to store the **session**, which behind the scenes Rails will put in a **cookie** – a tiny text file that will stick around on the user's hard drive and say, "Hey, this is the current user!"

Luckily, Rails gives us a session object to manage this process. The session object acts just like a _hash_.

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])
    if user && user.authenticate(params[:login][:password])
      # make a new key in our session object called :user_id
      # which gets stored in a cookie on our hard drive
      session[:user_id] = user.id.to_s
      redirect_to users_path
    else
      redirect_to login_path
    end
  end

  def destroy
  end
end
```

I bet you're asking why the heck we are typecasting `user.id` to a string.  Well, here's the deal: a cookie can really only store strings, and our ID is a whole object so we need to convert it to a string.

If we try to log in with a user we created, we'll see that it worked because we're redirected to the user index path. 

Let's make a helper method so that we know _who_ the current user is that's stored in that cookie.

###Creating a Current User Helper
Inside our ApplicationController, we'll write a method called `current_user`. Because all the controllers in our application inherit from ApplicationController, we will be able to access this method in all our controllers.

```ruby
# app/controllers/application_controller.rb
helper_method :current_user

private
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
```

Now, check this out. Anywhere in any of our views, we can write something like:

```html
<%= current_user.name %>
```

Now, we can use current_user in any of our views and know who's logged in.

###Logging Out
Now we're in the home stretch. What about logging out?

If 'logging in' is just storing some information in our session hash, to "log out" all we have to do is delete that information from our hash.

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])

    if user && user.authenticate(params[:login][:password]) 
      session[:user_id] = user.id.to_s
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
```

How would we delete a key/value pair from a normal hash?

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.where(email: params[:login][:email]).first
    if user && user.authenticate(params[:login][:password])
      # make a new key in our session object
      # which gets stored in a cookie on our hard drive
      # we'll store the user's ID to make for a fast
      # User.find later on
      session[:user_id] = user.id.to_s
      redirect_to users_path
    else
      redirect_to login_path
    end
  end
  def destroy
    # delete that key/value pair in our sessions hash
    session.delete(:user_id)
    redirect_to login_path
  end
end
```

Of course, our view needs a link to that delete method, but we've seen that before in other CRUD views.

```html
<%= link_to 'Log Out', logout_path, method: :delete %>
```

If you're redirected to the login page, it worked! 

That's basically it. There are, of course, a few gotchyas.

## Important Gotchyas

###Only Display Stuff If Logged In

Currently, on our users index page, we're trying to display:

```html
<%= current_user.name %>
```

If we log out, current_user won't have anything in it – it will be ``nil``. You can't call a ``.name`` on nil. Most likely, we'll want to only try to show ``current_user.name`` _if_ we're logged in.

Well that's not too tough – we just have to check if there's anything stored in ``session[:user_id]``! Let's make another helper. This one will be written in the `sessions_helper.rb` file that lives in the helpers directory:

```ruby
# app/helpers/sessions_helper.rb
def logged_in?
  session[:user_id] != nil
end
```

We can use that in our view anywhere we need to!

```html
<% if logged_in? %>
  Logged in as: <%= current_user.name %> <%= link_to 'Log Out', logout_path, method: :delete %>
<% else %>
  <%= link_to 'Log In', login_path %>
<% end %>
```

##Conclusion
This has all been lot – I know.

Individually, each piece of the puzzle builds on basic Ruby and Rails building blocks you've mostly already learned.

You should definitely revisit each of the pieces we've talked about today, and make sure you understand them individually. Start up a new application, write it from scratch. Then scrap it and do it again. The more you write it, the better you'll get it.