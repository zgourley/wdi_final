#HTTParty...'Bout It, 'Bout It!

##Learning Objectives
* More Rails practice!
* Interact with an API to "GET" some data
* Present that data in your view
* PARTY ON HTTP AND RAILS!!!

##Roadmap
Today is all about partying! We're going to learn how to use a really sweet gem called HTTParty to retrieve data from Github's API. Your mission will be to grab some data from Github's API so that you can create a directory of all the members of our class Github team that shows their picture and links to their Github profile page. 

I will spend a few minutes showing you the basics of the Github API and how to use HTTParty. Then I will turn you loose to party. You can party alone or pair up and tackle this lab together: the choice is yours!

##A Quick Introduction to Github's API
So far, all the data we have retrieved to use in our Rails applications has been from our own database. Well, it's time for a switcharoo! Github has a particularly awesome, data-rich, developer-friendly API. 

Today, we're going to let Github bring the data to the party and then we can focus on how to present that data in our view. For now, you can think about Github's API as an interface to access their data. It's kind of like a website, but instead of responding to our HTTP requests with HTML, their API is responding with JSON. 

###Let's take a look at a few basic examples:
* `https://api.github.com/zen`
  - If we make a request to this API _endpoint_ from our browser, we can see that Github sends us back some text. And that text changes each time we hit that endpoint.
* `https://api.github.com/defunkt`
  - Let's make this request to this endpoint and see what we get back...that looks like JSON!

###Github Access Tokens
To take full advantage of Github's API, we need to _authenticate_ with them on each request we make. The way Github handles this is via an access token. When we provide our access token with each request, two main things happen:

* Our rate limit jumps from 60 requests per hour to 5,000 requests per hour. Boom!
* We are able to access data--like a list of team members, for example--that are not available without an access token.

Let's go to Github to grab an acess token! 

##A Quick Introduction to the HTTParty Gem
So far we have just been accessing Github's API from the browser. But how to we access their API from a Rails application so that we can actually do something cool? Great question! The answer is: HTTParty!

HTTParty gives us a way to send HTTP requests to servers and then have the data that comes back automatically parsed and converted into Ruby objects for us (usually arrays and hashes).

HTTParty isn't just for Rails, though. We can use it with any Ruby app. In fact, we can even use it in a regular, old Ruby console (like Pry or IRB). Let's do that!

1. Let's install the gem globally:

  ```bash
  $ gem install httparty
  ```

2. Let's use it with Pry! Open up a Pry session in your terminal and type the following:

  ```ruby
  $ require 'httparty'
  ```

3. Now we are ready to party! Let's start with something easy, just like we did in our browser:

  ```ruby
  $ HTTParty.get("https://api.github.com/zen")

  # => "Some random sentence."
  ```

4. We can also get back info about a single user:

  ```ruby
  $ HTTParty.get("https://api.github.com/users/defunkt")

  # => {"login"=>"defunkt",
  #      "id"=>2,
  #     "avatar_url"=>"https://avatars.githubusercontent.com/u/2?v=3",
  #      ...
  #    }
  ```

5. So let's try to do something new. Let's try to get back all the members of our Github team!

  ```ruby
  $ HTTParty.get("https://api.github.com/teams/1365559/members")

  #=> {"message"=>"Not Found",
  # "documentation_url"=>"https://developer.github.com/v3"}
  ```

We get that error because this particular resource we are trying to access requires that we provide an access token. Let's fix that. We'll add it to the URL as a query string:

  ```ruby
  $ HTTParty.get("https://api.github.com/teams/1365559/members?access_token=<YOUR_ACCESS_TOKEN_HERE>")

  # this returns an array of hashes of all the users!
  ```

We've been using HTTParty inside of Pry, but guess what? You can use it EXACTLY the same way inside of a Rails controller action! One thing you will probably want to do is assign the return value of that HTTParty.get method call to an instance variable...something like `@students`.

Last thing: don't forget that the data is an array of hashes. That means that to access the elements inside those hashes you have to use square brackets (no dot notation--we don't have getter methods to do that!).

  ```ruby
  students[0]["login"]
  #or
  students.first["login"]
  ```

##Some Helpful Reminders to Get You Started and Keep You on Track
Okay, dare I say it?...it is time to party! Here's some reminders if you get stuck:

1. Start up a new Rails app!
2. Make a controller (call it something like `static_pages`).
3. Add a route for an `index` action in your StaticPages controller.
4. Define an `index` action in your StaticPages controller.
5. Create a new view template that corresponds to your StaticPages controller's `index` action.
6. Try to access that view in your browser to make sure that everything is working.
7. Add HTTParty to your Gemfile and get ready to PARTY!!!
8. Use HTTParty in your `index` controller action to **get** (hint, hint!) a list of everyone that is a member of the wdi-la-15-students Github team. **(Don't forget that you will need to include your Github access token in your request).**

##Some Helpful Resources
* [The Getting Started Guide for Github's API](https://developer.github.com/guides/getting-started/)
* [The complete Github API documentation](https://developer.github.com/v3/)
* [The HTTParty documentation](https://github.com/jnunemaker/httparty)
* The Github API endpoint to **get** a list of all our team's members: `https://api.github.com/teams/1365559/members?per_page=100&access_token=<YOUR_ACCESS_TOKEN_GOES_HERE>`

##Bonus Challenges
* Style the pants off your page using Bootstrap and/or SASS!
* Do something else cool with Github's API--take a look at the documentation to see what kind of information you can get from them!
* Use HTTParty to submit a POST request to Github--see the documentation for what they will allow you to POST!