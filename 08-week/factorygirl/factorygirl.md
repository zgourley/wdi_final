# FactoryGirl

------



### OBJECTIVES

- Be able to explain what a fixture is
- Be able to explain what FactoryGirl is
- Be able to use FactoryGirl and TDD to build a basic User model


------

***In 50 words or less, what is a “fixture”?***

- A baseline state that exists at the start of a test (e.g., I want to create a generic default User that has a first name, a last name and a DOB). The purpose of a test fixtures is to ensure that there is a well known and fixed environment in which tests are run so that results are repeatable. 


***Fixtures are beneficial for a few reasons: 1) Avoid duplication (DRY code), 2)Avoid having to change multiple tests when your schema or validations are changed***

***EXAMPLE -> Creating a new object for every test***

``` ruby
it "can tell which user is older" do
  eldest   = User.create(date_of_birth: '1971-01-22')
  youngest = User.create(date_of_birth: '1973-08-31')
  expect(User.find_eldest).to eq(eldest)
  expect(User.find_youngest).to eq(youngest)
end
```



***In 50 words or less, what is Factory Girl?***

- A ruby gem that allows us to create fixtures.


## ***START A NEW RAILS APP***

``` 
rails new factory-girl-lesson -T --database=postgresql --skip-bundle
```

We’re skipping test unit because we are going to replace it with Rspec.

## ***UPDATE YOUR GEMFILE***

``` ruby
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
end
```

## ***RSPEC SETUP***

- Install Rspec ```rails g rspec:install```
- Update the ```.rspec``` file to include ```--format documentation``` and remove ```--warnings```.


## ***USER MODEL SETUP***

- Create a ```User``` model with three attributes


``` 
rails g model user first_name:string
```

- Migrate your database



- Below is what ```/spec/factories/users.rb``` will look like


``` ruby
FactoryGirl.define do
  factory :user do
    first_name "MyString"
  end
end
```



## ***THE FIRST TEST***

***This test will fail***

``` RUBY
  it "should have a user named Glenn" do
    user = FactoryGirl.create(:user)
    expect(user.name).to eq("Glenn")
  end
```

***This test will pass***

``` ruby
  it "should have a user named Glenn" do
    user = FactoryGirl.create(:user, first_name: "Glenn")
    expect(user.name).to eq("Glenn")
  end
```

- Explain to students that you can override the default values of the object by passing a hash as the second argument


## ***The difference between #build_stubbed and #create methods***

``` ruby
  it "should have a user named Glenn" do
    user = FactoryGirl.create(:user, first_name:"Glenn")
    user2 = FactoryGirl.build_stubbed(:user, first_name:"Glenn")
    expect(user.name).to eq("Glenn")
  end
```

- Explain that the #create method creates an actual record in the test database and that build_stubbed “fakes” it. Unless there is a specific reason to have the data in your database use #build_stubbed. Show the students that they both create ActiveRecord Ids.


***Using the #build method creates a record without an ID***

``` ruby
  it "should not have an ID if I use the build method" do
    user = FactoryGirl.build(:user)
    expect(user.id).to be_nil
  end
```

## ***TDD -> Building the last_name method/property***

``` ruby
describe "#last_name" do
    it "should return the last name of the user" do
      user = FactoryGirl.build_stubbed(:user)
      expect(user.last_name).to eq("Harris")
    end
end
```

- Give the students 5-10 minutes to make this test pass. Mention that they should make the test pass without passing last_name as an argument.


``` ruby
    it "should return the last name Johnson" do
      user = FactoryGirl.build_stubbed(:user, last_name:"Johnson")
      expect(user.last_name).to eq("Johnson")
    end
```

- Give the students 5-10 minutes to make this test pass


***What about model validations?***

- Have students add the following validation to user.rb. Run Rspec and watch it fail


``` ruby
  validates :last_name, presence:true
```

## ***TDD -> Building the last_name method/property***

- Write the test with the students while actively engaging them. Watch the test fail and give them 5-10 minutes to make the test pass 


``` ruby
  describe "#full_name" do
    it "should return a full name" do
      user = FactoryGirl.build_stubbed(:user,first_name:"Barack", last_name:"Obama")
      expect(user.full_name).to eq("Barack Obama")
    end
  end
```



## ***TDD -> Building an admin method/property***

- Write the test with the students. Give them 5-10 minutes to make it pass. Mention that you’ll need to write the migration to populate the admin field with ```false``` by default. They will need to use Google to get the right answer.


``` ruby
  describe "#admin" do
    it "should return false by default" do
      user = FactoryGirl.build_stubbed(:user)
      expect(user.admin).to be_falsey
    end
  end
```



------



#### FINISHED USER SPEC FILE

`/spec/models/user_spec.rb`

``` ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  it "should return a valid user" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.build_stubbed(:user)
    expect(user.first_name).to eq("Glenn")
    expect(user.id).to_not be_nil
  end

  it "should not have an ID if I use the build method" do
    user = FactoryGirl.build(:user)
    expect(user.id).to be_nil
  end

  it "should not save without a valid last name" do
    p user = FactoryGirl.build_stubbed(:user, last_name:nil)
  end

  describe "#last_name" do
    it "should return the last name of the user" do
      user = FactoryGirl.build_stubbed(:user)
      expect(user.last_name).to eq("Harris")
    end

    it "should return the last name Johnson" do
      user = FactoryGirl.build_stubbed(:user, last_name:"Johnson")
      expect(user.last_name).to eq("Johnson")
    end
  end

  describe "#full_name" do
    it "should return a full name" do
      user = FactoryGirl.build_stubbed(:user,first_name:"Barack", last_name:"Obama")
      expect(user.full_name).to eq("Barack Obama")
    end
  end

  describe "#admin" do
    it "should return false by default" do
      user = FactoryGirl.build_stubbed(:user)
      expect(user.admin).to be_falsey
    end
  end

end

```

#### FINISHED FACTORY

`/spec/factories/users.rb`

``` RUBY
FactoryGirl.define do
  
  factory :user do
    first_name "Glenn"
    last_name "Harris"
  end

end

```

------

### REFERENCES

- Getting started with FactoryGirl -> https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
