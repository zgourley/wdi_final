#Riding the Rails - Next Stop: Validation Station!

##Learning Objectives
* Understand what validations are and why they're important
* Implement server-side model validations
* Use the error messages that Rails generates to provide helpful information to users
* Use Rails' `flash` hash to send messages from your controller to your views

##Roadmap
We'll start with a conversation about validations and why they're important and then we will add validations to the starter app provided in the class repository. 

##Some Helpful Info About Validations
###Good Resources
[Rails Active Record Validation Docs](http://guides.rubyonrails.org/active_record_validations.html)

###What do we mean by "validations"?
Validations can be implemented a variety of different ways, but broadly speaking, when we say "validations" we are talking about verifying that the data we receive meets certain constraints before we allow it to be saved to our database.

Validations can be implemented on the client-side, the server-side, or even better, both!  If you are only going to have one form of validation, let it be server-side, for goodness sake!  

Adding client-side validation IN ADDITION to server-side validation can sometimes provide a better user experience by giving immediate feedback to users if they make a mistake filling out a form without first sending a request to the server and waiting for it to respond.  

Because client-side code can be accessed by the user, however, this is inherently less secure at ensuring valid data and shouldn't be used as a replacement for server-side validation.

##Let's Add Some Validations! 

1. We need to start by updating our user model.
    Let's start by making a list of all the things we want to validate:

   * **name**
        * we want to require that users provide a name
    * **email**
        * users must provide an email
        * the email must be unique (someone else can't have already signed up with that email address)
        * the email must be formatted properly
    * **password**
        * users must provide a password
        * the password must be between 6 and 20 characters
        * we also want users to enter their password twice when they sign up to confirm that they entered it correctly

      We will need to add the following code in our model to add validations:

        ```ruby
        validates :name, presence: true
        validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
        validates :password, presence: true, confirmation: true, length: { in: 6..20 }
        ```

      Additionally, to get the password validation to work, we will also need to make sure we have an `attr_reader` for `:password` in our User model:

        ```ruby
        attr_reader :password #add this line right below our list of fields

        #we also need to create an @password instance variable and set it's value in our setter method
        def password=(unencrypted_password)
          unless unencrypted_password.empty?
            @password = unencrypted_password
            self.password_digest = BCrypt::Password.create(unencrypted_password)
          end
        end
        ```

2. Let's update our signup form to add a field for `password_confirmation`:

    ```html
    <div>
        <%= f.label :password_confirmation %>
        <%= f.password_field :password_confirmation %>
    </div>
    ```

3. Let's update the `user_params` method in our users controller to permit `password_confirmation`:

    ```ruby
    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    ```

  While we're at it, let's also make a change to automatically sign a user in when they sign up:

    ```ruby
    #this line will automatically log a user in when they successfully sign up for a new account
    #add it inside your create action right after "if @user.save"
    session[:user_id] = @user.id.to_s
    ```

4. Now our validations are working, but it would be helpful if a user could see error messages if they aren't able to sign up. Let's look at some error messages in our Rails console and then we can add the error messages to the view.

    Here's the code we will use to add the error messages to the view:

    ```html
    <% if @user.errors.any? %>
      <div>

        <h4 class="text-danger"><%= pluralize(@user.errors.count, "error") %> prevented you from signing up for an account:</h4>

        <ul class="list-group">
          <% @user.errors.full_messages.each do |msg| %>   
            <li class="list-group-item list-group-item-danger"><%= msg.downcase %></li>
          <% end %>
        </ul>            

      </div>
    <% end %>
    ```

##Flash Messages!
Rails' flash hash is a great way to pass messages from one controller action to another. Anything we set in the flash will be exposed to the very next action and then cleared out. This is a super useful tool for doing notice and alert messages that get displayed in the view after some kind of action. 

Using a flash is comprised of two parts:  setting the flash message in the controller and then displaying the flash message in the view.

For example, we can use the flash to display a welcome message to a user right after they sign up for our site. Here's what our users controller `create` action would look like:

```ruby
def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id.to_s
    flash[:welcome] = "Thanks for signing up, #{@user.name}!"
    redirect_to users_path
  else
    render :new
  end
end
```

And then we would need to pick a place to display this in our view. We could put this in the page that we are redirecting to, but it is common to place flash messages inside the `application.html.erb` layout template:

```html
<% if flash[:welcome] %>
    <h4 class="bg-success flash"><%= flash[:welcome] %></h4>
<% end %>
```

We can also use the flash hash for displaying alert messages to a user. For example, if they enter the wrong email address or password when they try to log in:

```ruby
def create
  user = User.find_by(email: params[:login][:email])

  if user && user.authenticate(params[:login][:password]) 
    session[:user_id] = user.id.to_s
    redirect_to users_path
  else
    flash.now[:error] = "Your email address or password are incorrect."
    render :new
  end
end
```

Notice here that we are using the `.now` method for this one. Using `.now` ensures that the flash message will not be available to the next action. Generally, you will use the `.now` method inside the else statement of a controller action where you are rendering a view instead of redirecting to a new controller action.

Don't forget that we need to display the flash message somewhere. Let's also add this one to the `application.html.erb` file:

```html
<% if flash[:error] %>
    <h4 class="bg-danger flash"><%= flash[:error] %></h4>
<% end %>
```

##Bonus!
For extra practice, explore the [documentation for Rails validations](http://guides.rubyonrails.org/active_record_validations.html) and implement three additional validations on the User model. You can generate a migration to add additional attributes to the model if you want (ex. add age and then write a validation requiring that the value be an integer).
