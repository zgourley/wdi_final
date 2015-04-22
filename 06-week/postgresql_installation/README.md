Set up Postgres for Ruby on Rails Development
=====
This guide will point you on how to setup Postgresql in your machine as well
as to configure it to be used with Ruby on Rails

Install and configure Postgresql
---
If you are using a Mac follow this [guide](https://www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql)
If you are using Ubuntu or a debian based Linux distro, read the last part of the above link
and follow [this guide](https://help.ubuntu.com/community/PostgreSQL#line-52)

Create a new app with Postgresql as the data store
---
In the command line run:
`rails new MyNewAppName -d postgresql`

Make sure to create the database by running:
`rake db:create`

Migrate an app from other data store to Postgresql
---
If you have an app that has sqlite3 as the data store you can easily migrate it
by doing the following:

1. Replace the sqlite3 gem for the pg gem in your `Gemfile`

    ```ruby
    #...
    gem 'pg'
    #...
    ``` 

2. Configure your `database.yml` configuration file to use postgresql
by changing the adapter, removing the timeout and pointing to the new databases

    ```yml
    default: &default
      adapter: postgresql
      encoding: unicode
      pool: 5
    
    development:
      <<: *default
      database: blog_development
      
    test:
    <<: *default
    database: blog_test
        
    production:
      <<: *default
      database: blog_production
      username: awesome_blog
      password: <%= ENV['AWESOME_BLOG_DATABASE_PASSWORD'] %>
    ```

3. Create the new database:
`rake db:create`

4. Optionally you can import the data with pgloader by following this [guide](http://pgloader.io/howto/sqlite.html)
