#Authentication with Rails, Pt. I

##Learning Objectives
- Learn a sensible, straightforward approach to user authentication in Rails
- Build a user model with an encrypted password
- Authenticate users based on the password they provide

##Roadmap
Today's lesson on user authentication will be taught in two parts. The first part will deal with how to securely store an encrypted password and how to authenticate a user based on that encrypted password. The second lesson will be about managing sessions (a.k.a. logging in and out). We are going to cover a lot today. The goal is not to memorize how to implement authentication in Rails. Rather, the goal is to understand conceptually how we are going to approach authentication so that when you reference this code later on, you will understand what it is doing and how it is all tied together.

##What is Authentication?

Authentication is just a fancy term used to describe how we know what person is accessing our application. It's a way to verify identity. If you say you're Dave, let's double check before we assume you are.

> **Activity (5 minutes):** Before we dive too deep into code, let's take a couple minutes to psuedocode. Based on your experience as a user, how do websites usually check that you are who you say you are? How would you approach actually doing the checking? 

> Working in threes, see if you can quickly pseudocode how to tell do a check like that.

Now that we've looked at it from a high-level, let's get into coding. We're gonna walk through a simple but solid way we can use Rails to authenticate a user.

##Setup 

###Rails New!
We're gonna be working on an entirely new Rails app, so let's start from scratch.

```bash
$ rails new authentication -T
```

###Generate our Model!
We're going to need a model that represents someone using our application. It's worth mentioning that `User` is a frequently used name for this model, but there's no magic in that word. A user is just a regular Ruby object. Rails nor Ruby has any idea what we intend to do with it.

Let's assume we're gonna log in via email & password. We'll leave the password stuff for in a minute, but let's give it an email field.

```bash
$ rails g model User name email
```

Before we forget, let's run that migration file and get a users table created in our database:

```bash
$ rake db:migrate
```

Now we can get to the fun part!

##What is Encryption?
We're used to using passwords – we use passwords on everything. What is the point of a password? It gives us a piece of information only we know.

But passwords are a sensitive thing. If we write down our password on a piece of paper next to our computer, anyone who sits down at our computer can pretend to be us. It's important that no one knows our password but us – that's why we encrypt them.

If our passwords were stored as plain text in our database, anyone looking at our database could pretend to be anyone.

Instead, we'll use encryption, converting our password to gibberish. Then, when someone sends a password to our server to try to log in, we'll convert that plain text password to gibberish and compare whether the gibberish we have stored in our database is the same as what we just converted.

##BCrypt: Our Encryption Engine of Choice
Our encryption engine of choice is called `bcrypt`. It's extremely popular, very secure, and easy to use. 

In fact, it's so commonly used with Rails that they have already added it to our Gemfile for us. We just need to uncomment it:  

```ruby
# Gemfile
gem 'bcrypt', '~> 3.1.7'
```

Whenever we modify our Gemfile, we need to download and install the new gems we added.  Here's how we do it:

```bash
$ bundle install
```

## Our User Model
In our User model, we've got two tasks we need to take care of:

* Take a password from a user (submitted via a form), encrypt it, and then store _that_ instead of the plain text
* Check whether a user is who they say they are by comparing a plain text password submitted via a login form to our saved encrypted one

### Converting Plaintext to an Encrypted String
We want to be able to do something obvious with our user, something like:

```ruby
# user = User.new
# user.password = 'amazing'
# user.password # => '$2a$10$4LEA7r4YmNHtvlAvHhsYAeZmkxeUVtMTYqwIvYY76EW5GUqDiP4.'
```

In cryptography, we'd call that unique string a _digest_. We want to store our _encrypted_ password in the database, so we're going to need to add a column to our users table called `password_digest`. That sounds like a job for a migration file!

```
$ rails g migration AddPasswordDigestToUsers
```

That will give us an (almost) empty migration file that we need to write some code in before running. This code will add a new column to our users table:

```ruby
class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
  end
end
```

Don't forget to run that migration!

```bash
$ rake db:migrate
```

Now that we've got a place to store password_digests in our database, we need some way of getting them there.

When we use a method to set an attribute, that's called a setter (using a method to read an attribute is a getter method), so we'll have to create a setter method for password to have it do what we want.

```ruby
# app/models/user.rb
class User
  def password=(unencrypted_password)
    # we'll write some code right here in a minute
  end
end
```

Now let's make use of BCrypt:

```ruby
# app/models/user.rb
class User
  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password) 
  end
end
```

As for encrypting and saving that value to the database, that's it. When you save an instance of a User model, you'll have an encrypted password in the database. Like so:

```ruby
shawn = User.new(name: 'Shawn', email: 'shawn@example.com', password: 'password')
shawn.save #=> #<User id: 1, name: "Shawn", email: "shawn@example.com", created_at: "2015-04-14 19:04:26", updated_at: "2015-04-14 19:04:26", password_digest: "$2a$10$nuEE3jYRhrXfhg9dP7jbAuyOoYLZIuAumNn00WZqhYr...">
```

##Authenticating
We've got users. We've got safe, _encrypted_ passwords – something that only the user will know. We have the data we need to know if a user is who they say they are – we just need a tool to do the checking.

We'll call our method `authenticate` (seems appropriate), and we'll make sure we pass in whatever they claim their password to be.

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end
end
```

Believe it or not, that's it. Now you can look up a user, and check whether a password they've given you is _their_ password.

```ruby
User.create(email: 'shawn@example.com', password: 'awesome')

shawn = User.find_by(email: 'shawn@example.com')

shawn.authenticate('not-awesome') # false
shawn.authenticate('awesome') # => #<User id: 1, name: "Shawn", email: "shawn@example.com", created_at: "2015-04-14 19:04:26", updated_at: "2015-04-14 19:04:26", password_digest: "$2a$10$nuEE3jYRhrXfhg9dP7jbAuyOoYLZIuAumNn00WZqhYr...">
```

- - -
##A Few Gotchyas

###Why return `self` in our authenticate method?

The truth is, you can build this any way you like. But the benefit of returning `self` is that we can, later on (a.k.a the next lesson) _store_ our user somewhere, so we can access them easily later and know at all times who's logged in.

###No Access to @password
Currently, we don't have any access at all to the plaintext password that's sent into our `#password=` function. While we don't want to save it to the database, we might want to save it in memory, to be able to access it later. 

All we need is an ``@password`` instance variable, and a ``password`` getter method – that sounds like a job for ``attr_reader``.

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  attr_reader :password
  
  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end
end
```

This could prove useful if you want to do any checks before encrypting a password – making sure it's a specific length, or has certain characteristics, or something like that.

###Don't Encrypt An Empty String
We also may want to check to make sure an unencrypted password isn't _empty_. Imagine a page where there's an input to change your password if you want; if you don't input anything, it'll pass an empty string in as your argument to ``#password=``. It'll be just like we called:

``user.password = ""``

BCrypt will definitely still encrypt that – it is a string, after all.

You can imagine how shocking it would be to **not touch the password input** (because you don't want to change your password), and then later not being able to log in _because your password changed._ Not good UX.

So we can write a little failsafe to make sure we only encrypt if it's _not_ an empty string.

```ruby
def password=(unencrypted_password)
  unless unencrypted_password.empty?
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end
end
```

Now it'll only encrypt it when we pass a real, non-empty string in.

## Wrapping Up
At it's heart, all we've done is make a custom method to encrypt a string, and make another custom method to check whether that encrypted string matches a plaintext string.

It's easy to feel like users and logging in are _magic_, and they're really not. Authentication is just a matter of finding a way to _not_ store a plaintext password, but still be able to check it when we need to.

In **Part II** of this lesson, we'll talk about what to do once we've got a user authenticated – aka _keeping them logged in!_