#HEROKU DEPLOYMENT USING POSTGRES
--

###OBJECTIVES
```
* Be able to setup a Heroku account
* Be able to install dependencies that will allow Heroku deployment
* Be able to successfully deploy your Rails app to Heroku
```
--
***What is Heroku?***

- A cloud-based service that allows you to deploy your Rails app using Git


***What is rails_12_factor ?***

- A gem that makes running your Rails app on Heroku easier. 
    - Adds logging to std_out instead of a log file
    - Enables serving static assets

--

Before beginning please have your Heroku password/login handy. You'll need them to login to Heroku via the website and via the CLI.

***NOTE: If you know that you're going to deploy to Heroku you should be using Postgres in development. Because we haven't taught you how to do that yet, the instructions have been modified***

* Create a new rails app

`Command line`

```
rails new pg-test-app
cd pg-test-app
subl .
```

* Add the following lines to your Gemfile and then run `bundle install`.

`Gemfile`


```ruby

ruby '2.2.1'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'sqlite3', group: :development


```


* Generate a scaffold named "Post". In the migration created by the scaffold create a column named "title"



```ruby
#from command line

rails g scaffold Post title:string body:text
  
-------
#back on the command line
  
  rake db:migrate
```

* Create a seed file


```ruby
#seeds.rb

Post.create(title:'Post 1')
Post.create(title:'Post 2')
Post.create(title:'Post 3')
Post.create(title:'Post 4')
Post.create(title:'Post 5')

------

#from command line
rake db:seed
```

* Start your rails server and verify that your app is working

* Go to http://www.heroku.com and create a new empty app. After creating the app a list of deployment instructions should appear similar to what you find on Github when you create an empty repo.


```
# command line

$ heroku login

# enter your credentials
```



```
$ git init
$ heroku git:remote -a YOURHEROKUAPPNAME
$ git add -A
$ git commit -m 'push to heroku'
$ git push heroku master
$ heroku run rake db:migrate
$ heroku run rake db:seed
```