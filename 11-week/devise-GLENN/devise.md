# DEVISE

------

- Be able to explain what Devise is
  
- Be able to add Devise to an existing Rails app
  
  ​
  


------

Up until this point we have made you hand roll your own authentication. The main reason for this was to force you to understand how authentication works (creating/deleting sessions, cookie storage, etc.). 

Now that you’re familiar with how authentication works it’s time to explore other options. Implementing your own authentication is fine for small projects, but if security is a real concern you should avoid doing so; YOU ARE NOT A SECURITY EXPERT.

A popular Ruby gem for implementing authentication is Devise. The purpose of this class is to introduce you to Devise and the features you’ll most likely use.

------

## BUILD A GENERIC RAILS APP

- `rails new devise-lesson`
  
- `rails g scaffold User password`
  
  - Devise requires two parameters be passed when creating a new User, `email` and `password`
  


------

## ADDING DEVISE TO THE MIX

- `rails g devise:install`
  
  - After devise installs there will be a series of instructions which you should follow
  
- `rails g devise User`
  
  - This will create a new database migration that adds columns that Devise uses. Because it is boilerplate code it will try to re-add the `:email` column that we’ve already added. If this is the case, comment out this line `t.string :email,null: false, default: “"`
  
- Run all your migrations
  


------

## EXAMINING DEVISE’S HANDIWORK

- Devise has added routes to your `routes.rb` file. You’ll see the line `devise_for :users`. Run `rake routes` in your terminal to see the new routes it has created to handle user login/logout, signup/signin, password recovery, etc.
  
- Devise has added methods to your `user.rb` file:
  
  ``` ruby
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  ```
  
  - `:database_authenticatable` responsible for encrypting password and validating authenticity of a user while signing in.
  - `:registerable` allows new users to sign up
  - `:recoverable` allows users to recover their lost passwords
  - `:rememerable` manages creating and updating cookies
  - `:trackable` tracks info related to user sign in (e.g., last_sign_in, current_sign_in_ip)
  - `:validatable`creates all needed validations for a user email and password.
  


------

## DEVISE IN THE VIEWS

Add the following to your ***../app/views/users/index.html.erb*** file:

``` html
<% if user_signed_in? %>
  <%= current_user.email %>
  <%= link_to 'Logout', destroy_user_session_path, method: :delete %>
<% else %>
  <%= link_to 'Login', new_user_session_path %>
<% end %>
```

- Devise has created two helper methods that we see here `user_signed_in?` which returns true or false and `current_user` which returns the user object of the current signed in user.


------

## ADDING DEVISE METHODS IN THE CONTROLLER

Add the following line to your `users_controller.rb` file:

``` ruby
class UsersController < ApplicationController
  ...

  before_action :authenticate_user!, only:[:show,:edit,:update,:destroy]

  ...

```

Adding this `before_action` will verify that a user is logged in before performing the requested action.

------

## OPTIONAL

You can style the views that Devise uses by running the followign in terminal:

``` 

```





------

### RESOURCES

- (DOCUMENTATION)[http://www.rubydoc.info/github/plataformatec/devise/]
- (Link on Github)[https://github.com/plataformatec/devise]
