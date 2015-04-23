Using Oauth to connect to API's
===
Oauth is used for authorization between service providers, client apps
and users.

You can read about how it works
[here](http://blog.varonis.com/introduction-to-oauth/)

Using the oauth gem
----
We can use the oauth gem to consume oauth API's in our Ruby
applications (including Rails).

First you need to install the gem. In our case we want to make
available globally. So in the command line we type `gem install
oauth` 

You can read the documentation for the gem
[here](http://www.rubydoc.info/github/oauth-xx/oauth-ruby/master/frames)

We will be using only two classes from the library
[AccessToken](http://www.rubydoc.info/github/oauth-xx/oauth-ruby/master/OAuth/AccessToken)
and
[Consumer](http://www.rubydoc.info/github/oauth-xx/oauth-ruby/master/OAuth/Consumer)

Using it to consume API's
----
We will be using the oauth gem to consume the Yelp search
[API](https://www.yelp.com/developers/documentation/v2/search_api)

You can take a look at the file in this folder as an example. The steps to consume an API are are the following:

1. Require the gem

  ```ruby
  require 'oauth'
  ```
2. Specify the consumer key, consumer secret, access token and access token secret given to you by the Oauth provider (Yelp in our case)

  ```ruby
  # replace each with your own
  consumer_key = '4_cRfPXaA3HfZNHrbBD9yQ'
  consumer_secret = 'JVIbnThLtilI91hmpO9BGzsKAKM'
  access_token = 'dDRxE9tG4I6bU50jJpIsNd6i5k7Nug-C'
  access_token_secret = 'vTlk5EoDLnHqsds2UtjX4-zBGoI'
  ``` 
3. Create a new consumer like so

  ```ruby
  @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {site: 'http://api.yelp.com'})
  ```
4. Generate a new access token and use it to issue http requests

  ```ruby
  access_token = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)
  ``` 
5. Once you have the token you can talk to the provider issuing http
   requests

  ```ruby
  access_token.get('/v2/search?term=dentist&location=Chicago')
  ```
