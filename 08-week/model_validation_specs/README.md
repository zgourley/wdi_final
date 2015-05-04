#RSpec: Specs for Rails Model Validations

##Learning Objectives
* Practice the TDD Workflow 
* How to set up Rails to use RSpec
* How to write specs that test model validations (and one instance method)

##Roadmap
We will be following a TDD workflow today, writing our tests first followed by the code to make those tests pass.  We'll write the tests together, but you will be responsible for writing the code to make them pass.

##Rails Setup
1. Let's start a new Rails app:  

  ```
  rails new modelspecs -d postgresql -T
  ```

2. Let's make a new database:  

  ```
  $ rake db:create
  ```

3. Even though we don't actually have any database migration files yet, we need to go ahead and run `rake db:migrate` because it sets up the `schema.rb` file that Rails uses to build the test database:

  ```
  $ rake db:migrate
  ```

##RSpec Setup
1. Let's add the RSpec Rails gem to our Gemfile:
    
    ```ruby
    group :development, :test do
      gem 'rspec-rails', '~> 3.2.1'
    end
    ```

2. Run `$ bundle install` to add this gem.

3. Now let's setup RSpec in our project:  

  ```
  $ rails g rspec:install
  ```

  This command generates four things in our Rails application:
  * The **.rspec** file: This is where the RSpec run options go. There are two defaults in this file.
    - The first is `--color`, which gives us colored output in our terminal (red for failing examples, green for passing examples, and yellow for pending examples).
    - The second default is `--require spec_helper`, which ensures that our `spec_helper` file is always required.
  * The **spec** directory, which is where all our specs will go. We will create subdirectories like `model` and `controller` when we need them.
  * The **spec_helper.rb** file, which contains general RSpec settings.
  * The **rails_helper.rb** file, which requires `spec_helper`, loads the Rails environment, and contains settings that depend on Rails. 

##Let's get to testing!
1.  Make a new directory inside the `spec` folder called `models`.

2.  Make a new file inside `spec/models/` called `user_spec.rb`.

3. Let's start by setting up our first spec:

  ```ruby
  require "rails_helper"

  RSpec.describe User do
    it "is invalid without a first name" do
      user = User.new(first_name: nil, last_name: "Smith", email: "roger@example.com")
      expect(user).to be_invalid
    end 
  end
  ```

  Before we run this, let's break down each of these parts:

    * The `"require rails_helper"` on line one refers to the file that contains all the Rails-related configuration that is common to all our tests. We are going to leave everything in here at it's defaults for now.
    * On line 3, we are using the `RSpec.describe` method. In RSpec, the `describe` method is used to define a suite of tests that share a common setup. The `describe` method takes one argument (usually a class name or a string), followed by a block. The argument describes what the test suite will cover, and the block contains the test suite itself.
    * Our actual test (a.k.a. "example", a.k.a. "spec") is defined with the `it` method. The `it` method takes a string argument that is used to describe what this particular spec is testing. The other thing the `it` method takes is a block, which is where the body of the spec is declared.
    * In the body of our spec, we do two of the most common things that you will do in a spec:
      - initialize an object (in this case, `user = User.new`)
      - declare some kind of expectation about that object (in this case, `expect(user).to be_invalid`)

4. Now let's run our test and see what happens. There are a few ways we can run our test:

  ```
  $ rspec
  ```

  This command will run all of our spec files for our whole application. Depending on the version of RSpec you have installed globally, you might have to prepend `rspec` with `bundle exec`, like so:

  ```
  $ bundle exec rspec
  ```

  Sometimes we don't want to run all of our specs for our entire application. This can be slow if we have lots of tests and that overhead is unneccessary if we are currently working on one spec file. We have the option to only run spec files that are in a specific directory, or, alternately, we can run a single spec file by specifying it after the `rspec` command:

  ```
  $ rspec spec/models/
  ```

  or

  ```
  $rspec spec/models/user_spec.rb
  ```

5. When we run our test using one of the methods above, we see an ugly stack trace and no information from RSpec. The error message at the top of the stack trace says `uninitialized constant User`. That's because we haven't created a User model yet. D'oh!

 Let's fix that:

 ```
 $ rails g model User first_name last_name email
 ```

 * RSpec will try to create a `user_spec.rb` file for us, but because we already created this file ourselves, Rails will ask if it should overwrite the file with a new, empty file.  We want to enter `n` because we want to use the file we already created.

6. As we already know, Rails created a new migration file for our users table when we ran `rails g model`.  Let's go ahead and run our migration:

  ```
  $ rake db:migrate
  ```

7. Now, if we run `rspec` again, we can see that we actually get information from RSpec this time! In fact, we can see that we have `1 example, 1 failure`. Let's make that test pass!

8. We can make it pass by adding a validation for `first_name` to our model.

  ```ruby
  class User < ActiveRecord::Base
    validates :first_name, presence: true
  end
  ```

  Red to green...boom!

9. Now let's write a spec that makes sure a user isn't valid if they don't have a last name:
  
  ```ruby
  it "is invalid without a last name" do
    user = User.new(first_name: "Roger", last_name: nil, email: "roger@example.com")
    expect(user).to be_invalid 
  end
  ```

10. When we run this test, we see that it fails.  You know how to make it pass. Add this to our User model:

 ```ruby
 # app/models/user.rb
 validates :last_name, presence: true
 ```

11. Now we want to make sure that a user has a full name. Let's write a test:

  ```ruby
  it "returns a user's full name as a string" do
    user = User.new(first_name: "Roger", last_name: "Smith", email: "roger@example.com")
    expect(user.full_name).to eq "Roger Smith"
  end
  ```


  You know the drill.  Run `rspec` and watch that sucker fail!

  Now we need to make it pass. Sounds like a job for an instance method:

  ```ruby
  # app/models/user.rb
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  ```

  Winner, winner, chicken dinner...you know that test just went from red to green!

12. Now it's time to get some testing in the mix for user's email address:

  ```ruby
  it "is invalid without an email address" do
    user = User.new(first_name: "Roger", last_name: "Smith", email: nil)
    expect(user).to be_invalid 
  end
  ```

  I bet you five bucks that test will fail.  Run `rspec` and then...boom!...pay me my money!

  Time to make that test pass. Add this to your User model and then bask in the glory of another passing test:

  ```ruby
  # app/models/user.rb
  validates :email, presence: true
  ```

13. How about a test to make sure that emails are formatted properly?  What a great idea!

  ```ruby
  it "is invalid if email isn't formatted properly" do
    user = User.new(first_name: "Roger", last_name: "Smith", email: "asdlk;@")
    expect(user).to be_invalid
  end
  ```

  Watch it fail...then make it pass!  We're gonna need a validation for email format in our User model.

  ```ruby
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  ```

14. We're gonna need some kind of safeguard against people signing up with an email address that already exists in our database:

  ```ruby
  it "is invalid if a user tries to sign up with an email that already exists in the db, regardless of capitalization" do
    user1 = User.new(first_name: "Roger", last_name: "Smith", email: "roger@example.com")
    user2 = User.new(first_name: "Roger", last_name: "Smith", email: "roger@example.com")
    user3 = User.new(first_name: "Roger", last_name: "Smith", email: "ROGER@example.com")
    expect(user1).to be_valid
    expect(user2).to be_invalid
    expect(user3).to be_invalid
  end
  ```

  Run `rspec`...that example is red. Make it green!

  We add the following code to our model to try to get this test to pass:

  ```ruby
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: {case_sensitive: false }
  ```

  That looks pretty good--let's run our test again. Uh oh. It's still failing. But why?! Well, it turns out that Rails validations that have uniqueness constraints (like validating that an email address must be unique, for example) need to check the database to see if another user already has that email address.

  To fix this our test, we need to call `.create` on `user1`, rather than `.new`. This will cause the record to be written to our test database, so that when the next two user email addresses are checked for uniqueness, there will be a record in our database to prevent them from passing validation.

  ```ruby
  it "is invalid if a user tries to sign up with an email that already exists in the db, regardless of capitalization" do
    user1 = User.create(first_name: "Roger", last_name: "Smith", email: "roger@example.com")
    user2 = User.new(first_name: "Roger", last_name: "Smith", email: "roger@example.com")
    user3 = User.new(first_name: "Roger", last_name: "Smith", email: "ROGER@example.com")
    expect(user1).to be_valid
    expect(user2).to be_invalid
    expect(user3).to be_invalid
  end
  ```
