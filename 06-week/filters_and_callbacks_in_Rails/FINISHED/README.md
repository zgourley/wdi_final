#Rails Filters and Callbacks: `before_action` and `before_save`

##Learning Objectives
* Learn how to use the `before_action` filter to prevent unauthorized access to pages in your app
* Learn how to use the `before_save` callback to normalize user-submitted data before saving it to your database

##Roadmap
###What is the purpose of the `before_action`?
In Rails, filters are methods that are run before or after a controller action. Today, we will focus on the far more common `before_action` method.

We can use the `before_action` filter to do things like make sure a user is logged in before they are allowed to access particular pages on our website. We can also the `before_action` filter to prevent a logged in user from accessing a resource that doesn't belong to them.

###What is the purpose of the `before_save` callback?
In a Rails application, objects may be created, updated, and destroyed. We can refer to this as the object's _life cycle_. Active Record has callback methods that we can invoke at the different stages of an object's life cycle. 

With callbacks, we can write code that will run whenever an object is created, saved, updated, deleted, validated, or loaded from the database.

Today we are going to focus on the `before_save` callback, but there are many other useful callbacks that you might want to use. Check out the [documentation](http://guides.rubyonrails.org/active_record_callbacks.html) for more information.

We can use the `before_save` callback to do things like format user-submitted data a particular way before saving it to the database (like capitalizing, downcasing, etc.). That's what we will use it for today.

##Using filters: `before_action`
###Requiring that a user be logged in
Let's start by making sure that a user is logged in before they can visit any pages on the website. If a user who isn't logged in tries to go somewhere, like say the users index view, we will redirect them to the login page and show a flash error.

Let's start by writing a private method in our users controller called `require_login`:

```ruby
# app/controllers/users_controller.rb
private
def require_login
  unless logged_in?
    flash[:error] = "You must be logged in to access that page."
    redirect_to login_path
  end
end
```

We can see that the `require_login` method makes use of the `logged_in?` method that we wrote in our Sessions Helper module (`sessions_helper.rb`). By default, methods written inside of helper modules are only available in our view templates. 

To make this method accessible to our controllers, we need to include it in our application controller:

```ruby
# app/controllers/application_controller.rb
include SessionsHelper
```

Okay, now that we have written our `require_login` method, let's invoke it using the `before_action` filter in our users controller:

```ruby
class UsersController < ApplicationController
  before_action :require_login
  #the rest of our controller omitted for conciseness...
end
```

Before we go to the browser to test this out, let's make sure that we display that flash error message somewhere. We'll put it in our `application.html.erb` layout template:

```html
<% if flash[:error] %>
  <h4 class="bg-danger flash"><%= flash[:error] %></h4>
<% end %>
```

Alright, so if we make sure that we are logged out and then try to visit the users index page, we should get redirected to the login page and see that flash error message.

But what if we aren't signed up for an account yet? Uh oh, we can't get to the signup view anymore! That's because our `before_action` is prohibiting us from getting to the `new` action in our users controller.

It's pretty absurd that we would have to be logged in before we can sign up. Let's fix this:

```ruby
# app/controllers/users_controller.rb

before_action :require_login, except: [:new, :create]
```

Simple as that--boom!

###Requiring that a user be authorized
Alright, let's go sign up another user and see what happens. Uh oh, that new user can visit the edit page of any other user. That's no bueno! We better fix that.

Let's write another private method in our users controller:

```ruby
# app/controllers/users_controller.rb
private
def authorized?
  unless current_user == User.find(params[:id])
    flash[:error] = "You are not authorized to access that page."
    redirect_to users_path
  end
end
```

Now that we've got this `authorized?` method, how the heck do we use it? What's that you say? Use another `before_action`? Exactly right! You're so smart ;)

```ruby
class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create] 
  before_action :authorized?, only: [:edit, :update]
end
```

Because we set the flash message for the `authorized?` method inside the `:error` key (the same key we used for the `logged_in?` flash message), we have already taken care of displaying this message in our view. Don't believe me? Go take a look at your `application.html.erb` file. See, told you so :)

That's it. Now if we try to visit the edit page of someone else, we get redirected and shown an error message. Easy peasy lemon squeezy.

##Using callbacks: `before_save`
We tackled some awesome validations yesterday to make sure that user-submitted data meets certain contstraints before we allow it to be saved to our database. 

That's a good start, but we also want to be sure that we normalize our data before we write it to the database. Taking care of things like capitalization or removing hypens from phone numbers are good examples of things we might want to normalize before writing it to our database. That way, when we display this data later on, we can be sure that there will be consistency to the way things are formatted.

Because this callback is concerned with doing something before saving an instance of our model, this callback will be written in our model.

Let's start by writing a private method in our User model:

```ruby
class User < ActiveRecord::Base

  #the rest of the model code omitted

  private
  def format_user_input
    self.name = self.name.titleize
    self.email = self.email.downcase
  end
end
```

Now that we have that private method written, we want it to get invoked every time a user record gets saved to the database. Let's use the `before_save` callback method:

```ruby
class User < ActiveRecord::Base
  before_save :format_user_input

  #the rest of the model code omitted

end
```

Important note: the `before_save` callback will run everytime a record is saved to the database, either by a `create` or an `update`. If you only want a method to run on before create or before update, you'll want to use either the `before_create` or `before_update` callback. Check the [documentation](http://guides.rubyonrails.org/active_record_callbacks.html) for more info!

These are really basic string transformations, but they should give you an idea of what you might be able to do using a `before_save` callback.
