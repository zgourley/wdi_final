#You've Got Mail: Rails Action Mailer!

##Learning Objectives
* Use Action Mailer to send emails from your Rails application

##Roadmap
Today we are going to be creating a Rails mailer that will automatically send a welcome email to a new user when they sign up for our app.  We will just be focused on implementing the mailer today. We won't be building any view templates or controller actions.  That will be left as an exercise for the reader ;)

##What is Action Mailer?!
Action Mailer allows you to easily send emails from your Rails application using mailer classes and view templates.  Mailers function very similarly to Rails controllers, so we should feel at home working with them.

##Setup
1. The first thing we'll need is a new Rails application. We'll just stick with SQLite today and we'll skip Test::Unit:

  ```
  $ rails new action_mailer -T
  ```

2. After you `cd` into your app directory, let's go ahead and generate a very basic User model:

  ```
  $ rails g model User name email
  ```

3. While you're at it, go ahead and run that migration:

  ```
  $ rake db:migrate
  ```

That's all the setup we need today to get started with Action Mailer. Boom!

##Let's do this thing!
1. Remember earlier when I said that mailers are a lot like controllers? Well, they even have their own generator. Let's use it now to get started:

  ```
  $ rails g mailer UserMailer
  ```

  Let's investigate what that generator did for us:

  * It made a file called `user_mailer.rb`. This is our mailer. If we look at it, we'll see that it's an empty Ruby class that inherits from `ApplicationMailer`. 
  * The next thing it created is a file called `application_mailer.rb`. This is the class that our UserMailer inherits from. Likewise, our ApplicationMailer inherits from `ActionMailer::Base`.
  * It also created three things related to email views:
    - a directory inside `app/views` called `user_mailer`. This is where we will create the actual html and text files that get sent.
    - inside the `app/views/layouts` directory, we also have a file called `mailer.text.erb` and a file called `mailer.html.erb`. These serve the same purpose as `application.html.erb`, but for our emails!

2. Okay, let's edit our UserMailer. Just like Rails controllers, mailers have methods called "actions" and have a corresponding view to display content.  Where a controller generates content like HTML or JSON to send back to the browser, a Mailer creates a message to be delivered via email.

  Let's add a method for sending a welcome email:

  ```ruby
  class UserMailer < ApplicationMailer
    default from: "info@officiallyshawn.com"
    
    def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: "Thanks for signing up")
    end
  end
  ```

  There are a few things here worth pointing out:

  * notice that the first thing we do is use the `default` method to specify who the sender of the emails in this mailer will be. This overrides whatever is specified in the `application_mailer.rb` file.
  * our `welcome_email` method takes in a parameter called user. That's because mailers don't have access to the request parameters, so we can't retrieve a user using an id inside `params`. Instead, we will pass in the user object we want to send the email to.
  * the last thing we do inside this method is invoke the `mail` method and pass it two arguments: the email address we want to send to and the subject of the email.
  * We are just defining one email today, but this mailer could have many email methods defined. For example, we could have a method that we use to send an email every time a user updates their password.

3. Next we need to create a mailer view. This will be the file that we send via email. Just like controllers, any instance variables we define in a mailer will be available for use in the corresponding mailer view.

  Let's create a new file called `welcome_email.html.erb` inside the `app/views/user_mailer/` directory.

  We'll also create a plain-text version of this email because some people still live in the dark ages and don't receive HTML emails. We'll call it `welcome_email.text.erb` and save it in the same directory.

  When the `mail` method is called, Action Mailer will detect that there are two templates (HTML and text) and it will automatically generate a `multipart/alternative` email.

4. Let's add some really basic content to our mail templates:

  ```html
  <!-- this is the one for our HTML template -->
  <h1>Thanks for signing up, <%= @user.name %>!</h1>
  <p>You're a total baller!</p>
  ```

  ```text
  Thanks for signing up, <%= @user.name %>!

  You're a total baller!
  ```

5. Now we need to configure Action Mailer in our development environment to send using our Gmail account.  To do this, we need to open up our `development.rb` file and add the following code:

  ```ruby
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: "example.com",
    user_name: ENV['gmail_username'],
    password: ENV['gmail_password'],
    authentication: 'plain',
    enable_starttls_auto: true
  }
  ```

  Notice how we're using environment variables for our `user_name` and `password`? That's because we don't want to put sensitive information in a config file like `development.rb`, because this is going to be checked into version control...which means that our username and password would end up on Github! That would be NO BUENO!

  Instead, we will use the Figaro gem to store our environment variables.

6. You can find the documentation for the Figaro gem [here](https://github.com/laserlemon/figaro). To use this gem, we need to do two things.

  First, add it to our Gemfile and bundle:

  ```ruby
  gem "figaro"
  ```

 Next, we run:
 
 ```
 $ figaro install
 ```

 That creates `config/application.yml` -- the file where we will store sensitive information as environment variables. The other thing it does is append our `.gitignore` file to make sure that `application.yml` doesn't get checked into version control.

 Now go add your Gmail username and password to the `application.yml` file. Make sure that you give the variable names the same thing that you used in your `development.rb` file.

7. Okay, now we're going to try to send an email from our Rails console.  First thing we need to do is create a new user that has a name and a real email address:

  ```ruby
  #in our Rails console

  shawn = User.create(name: "Shawn", email: "shawn@example.com")
  ```

  Now that we have a user with a real email address, sending that email should be easy as pie!  Back in our Rails console:

  ```ruby
  #in our Rails console

  UserMailer.welcome_email(shawn).deliver_now
  ```

  Oh snap! You just sent your first email using Rails' Action Mailer. Congratulations!

##A few things to be aware of...
* Email best practices is a huge topic that people dedicate their whole job to. Research and learn more if you are going to be doing a lot of emailing.
* Don't use Gmail in production to send emails. It is fine for development because it is fast and free, but it isn't suitable for production. If you are going to be sending emails in production use a service like Mandrill or Sendgrid.
* You'll notice that we are able to send emails using the `deliver_now` method. This makes sending emails super easy, but it does have a pretty big drawback: it is "blocking". That means that while the email is being processed and set, other requests to your Rails app are blocked. They can't be processed until that email is sent. In practice, you will probably want to send that email as a background job using something like [Sidekiq](https://github.com/mperham/sidekiq). 

##Bonus challenge
Right now, we're just sending out emails from the Rails console...not actually very practical in real life.  Build out a view with a simple sign up form for new users. In your users controller, set up your `create` action to automatically send an email to a user if their account is successfully saved.

If you're looking for another challenge: look into how to send the email in the background using something like [Sidekiq](https://github.com/mperham/sidekiq).

##Resources
* The [Rails Guide on Action Mailer](http://guides.rubyonrails.org/action_mailer_basics.html)
* MailChimp's very informative [Email Design Reference docs](http://templates.mailchimp.com/)
* Some [responsive email templates](http://zurb.com/ink/templates.php) from the fine folks at Zurb