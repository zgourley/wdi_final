#WDIMDb: Test Driving a Rails API

##Learning objectives
* Follow a TDD workflow to build a Rails JSON API
* Write integration tests using RSpec's request specs
* Extend Rails' `as_json` method to restrict the data we send to a client

##Roadmap
Today we're going to cover how to write integration tests for a Rails API. We're going to write the tests together and it will be your job to make each of them pass. The API we're building will handle CRUD for movies. When we're done, our API will provide the following endpoints:

  ```
  GET     /api/movies
  POST    /api/movies
  GET     /api/movies/:id
  PATCH   /api/movies/:id
  DELETE  /api/movies/:id
  ```

##A few words about testing our API
Our API will be responsible for returning (at most) two things:  an HTTP response status code and (sometimes) a response body.  Today, we will be writing integration tests to make sure that our API behaves as we expect it to.

Our integration tests will simulate the interaction between a client and our server.  For example, the client will submit an HTTP GET request for a list of all of the movies and--assuming that the request was sent properly--the server will respond with an appropriate status code and a list of movies formatted as JSON.

To write our tests, we will use RSpec's request specs.  It should be pointed out that these integration tests aren't a replacement for good model tests.  You should still be writing tests for your models, especially if they have lots of attributes, complex validations, complex associations with other models, and/or custom methods.

##Setting up our application
1. Let's get our new app started:
  ```
  $ rails new movies-api -d postgresql -T
  ```

2. If we spin up our Rails server and try to visit localhost:3000, we get an `ActiveRecord::NoDatabaseError` message. This is one of the differences between working with SQLite vs. PostgreSQL. This error is super easy to fix:

  ```
  $ rake db:create
  ```

3.  Add RSpec and Factory Girl to your Gemfile:

  ```ruby
  group :development, :test do
    gem "rspec-rails", "~> 3.2.1"
    gem "factory_girl_rails"
  end
  ```

4. Next up, bundle that shiz... 

  ```
  $ bundle
  ```

5. Now let's setup RSpec in our project:

  ```
  $ rails g rspec:install
  ```

6. Last thing: let's update our `inflections.rb` file to add a custom inflection for "API": 

  ```ruby
  ActiveSupport::Inflector.inflections(:en) do |inflect|
    inflect.acronym 'API'
  end
  ```

##Building our application
1. Let's get started by generating our model:

  ```
  $ rails g model Movie title rating year:integer description:text 
  ```

    **Note** -- This generator creates the following files:

    * a migration file to create a movies table in our database
    * our actual model file
    * a new model spec file
    * a new factory file

2. Let's go ahead and run `$ rake db:migrate`.

3. We're not going to be writing model tests today (though it would definitely be a good idea to have model tests in real life).  Instead, we're going to be writing integration tests to test for the HTTP response status code and the response body.

  That means that we need to create a new folder in our spec directory called "api".

  Inside this new folder we will create a file called `movies_spec.rb`.

4.  Okay, let's tackle our first feature.  We want our API to return a list of all movies.  Let's write a couple specs:

  ```ruby
  require "rails_helper"

  RSpec.describe "Movies API" do

    describe "GET request to api/movies" do
      before do
        FactoryGirl.create_list(:movie, 10)
        get "/api/movies"
      end

      it "responds with a 200 status code" do
        expect(response).to have_http_status 200
      end

      it "returns a list of movies" do
        movies = JSON.parse(response.body)
        expect(movies.count).to eq(10)
      end
    end  
  end #end RSpec.describe block
  ```

  * Alright, the first error has to do with our routes (we don't have any yet!).  Let's go fix it:

    ```ruby
    namespace :api do
      resources :movies, only: [:index]
    end
    ```

  * The next error we will get is `ActionController::RoutingError: uninitialized constant API` because we haven't defined API anywhere.  We can fix this error by doing the following:

        - create a directory called "api" inside the controllers directory.
        - inside our api directory, create a new file called "movies_controller.rb".
        - Now we need to write our controller.  It should look like this:

        ```ruby
        module API
          class MoviesController < ApplicationController
          end
        end
        ```
  * Now our test tells us that we don't have an index action in our controller.  We know how to fix that!

    ```ruby
    module API
      class MoviesController < ApplicationController
        def index
        end
      end
    end
    ```

  * The next error we should get is something about a missing template.  When someone sends a GET request to `/api/movies`, we want to respond with json so let's make that happen by adding the following to our controller:

    ```ruby
    module API
      class MoviesController < ApplicationController
        def index
          render json: Movie.all 
        end
      end
    end
    ```

  * Boom! Both our tests pass!

5. Now let's tackle getting our API to return a single movie.  We'll start by writing a test (duh!):

  ```ruby
  describe "GET request to api/movies/:id" do
    before do
      @movie = FactoryGirl.create(:movie)
      get "/api/movies/#{@movie.id}"
    end

    it "responds with a 200 status code" do
      expect(response).to have_http_status 200
    end

    it "returns a specific movie" do
      expect(response.body).to eq(@movie.to_json)
    end
  end
  ```

  * The first error it throws is that we don't have a show route.  We can fix this by adding the following to our `routes.rb` file:

    ```ruby
    namespace :api do
      resources :movies, only: [:index, :show]
    end
    ```

  * The next error is that we don't have a show action in our movies controller.  We can fix that!

    ```ruby
    #in our movies_controller.rb file
    def show
    end
    ```

  * That gives us an error saying that the template is missing.  That's because we haven't told our controller what to return and Rails isn't able to infer it.  Let's tell it what to do:

    ```ruby
    def show
      render json: Movie.find(params[:id])
    end
    ```

  * Sweet like bear meat!  That gets our test to pass.

6. Let's get serious and tackle creating a new movie.  You know we're going to start with a test.  Let's do it!

  Because we are going to be using request headers in several of our tests, we can DRY up our code by adding the following code just inside our `describe` block:

  ```ruby
  describe "Movies API" do

    let(:request_headers) do
      { "Accept" => "application/json", "Content-type" => "application/json" }
    end

    #rest of the code omitted for brevity
  end
  ```

  ```ruby
  describe "a successful POST request to /api/movies" do
    before do
      movie_attributes = { "movie" => FactoryGirl.attributes_for(:movie) }.to_json
      post "/api/movies", movie_attributes, request_headers
    end

    it "responds with a 201 status code" do
      expect(response).to have_http_status 201
    end

    it "creates a new movie" do
      movie = JSON.parse(response.body)
      expect(response.location).to eq("http://www.example.com/api/movies/#{movie['id']}")
    end
  end
  ```

  * First error:  we don't have a route.  Let's fix that:

    ```ruby
     namespace :api do
       resources :movies, only: [:index, :show, :create]
     end
    ```

  * Now our failing test tells us that we need a controller action:

    ```ruby
    def create
    end
    ```

  * Now is that oh so familiar missing template error.  We need to actually create something in our create action and then return something to the client:

    ```ruby
    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: movie
      end
    end

    private
    def movie_params
      params.require(:movie).permit(:title, :rating, :year, :description)
    end
    ```

  * Now we see that the error we are getting has to do with the status code. We're getting back a 200, but we want a 201. Let's fix that:

    ```ruby
    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: movie, status: 201
      end
    end
    ```

  * Cool, that's fixed. Now let's get our API to send the url for the newly created movie:

    ```ruby
    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: movie, status: 201, location: [:api, movie]
      end
    end
    ```

  * Our test passes now, but does it really work as we expect?  Let's try sending a POST request with Insomnia REST Client (first we will need to make sure that our Rails server is running):

    ```json
    {"movie": {
        "title": "The Big Lebowski",
        "rating": "R",
        "year": "1998",
        "description": "A cult classic!"
        }
    }
    ```

    When we try to send this post request, we can see that we are getting back a 422 status code (Unprocessable Entity).  This happens because Rails checks the incoming request for an authenticity token if the request is a POST, PUT, PATCH, or DELETE.

    This is set up as the default for all our controllers in our Application Controller.  It's that line that says `protect_from_forgery with: :exception`.  

    The reason why our test didn't catch this is because this feature is turned off by default in our test environment.  We can see this on line 27 of our test.rb file. Let's change that line from `false` to `true`.

    If we run our tests again, we can now see that they are failing because of an invalid authenticity token.

    To fix this, we need to add the following line of code in our movies controller to override this default behavior: `protect_from_forgery with: :null_session`.

    Now if we run our tests one more time, we can see that they all pass.  Boomzilla!

7. Let's tell our create action what to do if a record doesn't save because of a failed validation.  We'll start with a test:

    ```ruby
    describe "unsuccessful POST request to /api/movies" do
      before do
        movie_attributes = { "movie" => FactoryGirl.attributes_for(:movie, title: nil) }.to_json
        post "/api/movies", movie_attributes, request_headers
      end

      it "responds with a 422 status code" do
        expect(response).to have_http_status 422
      end

      it "responds with error messages" do
        errors = JSON.parse(response.body)
        expect(errors.count).to eq(1)
      end
    end
    ```

    * When we run our tests, we see that these new specs fail.  Hooray! Let's start by adding a simple validation to our model so that we can see what happens if a record doesn't save:

      ```ruby
      class Movie < ActiveRecord::Base
        validates :title, presence: true
      end
      ```

    * Running our tests again yields a different error: something about a missing template. Now, in our controller we will add an else block to our create action:

      ```ruby
      def create
        movie = Movie.new(movie_params)

        if movie.save
          render json: movie, status: 201, location: [:api, movie]
        else
          render json: movie.errors
        end
      end
      ```

    * Running our tests again gets one of the specs to pass, but we aren't getting the correct status code back.  Easy fix!

      ```ruby
      def create
        movie = Movie.new(movie_params)

        if movie.save
          render json: movie, status: 201, location: [:api, movie]
        else
          render json: movie.errors, status: 422
        end
      end
      ```

    * Green, baby!

8.  Alright, time to tackle updating a movie.  We're gonna need a test for that!

    ```ruby
    describe "successful PATCH request to /api/movies" do
      before do
        @movie = FactoryGirl.create(:movie)
        movie_attributes = { "movie" => { "rating": "R" } }.to_json
        patch "/api/movies/#{@movie.id}", movie_attributes, request_headers
      end

      it "responds with a 204 status code" do
        expect(response).to have_http_status 204
      end

      it "updates a movie's attributes" do
        expect(movie.reload.rating).to eq("R")
      end
    end    
    ```

    * Okay, no surprise here.  The first error we get is a routing error.  This will fix it:

      ```ruby
      namespace :api do
        resources :movies, only: [:index, :show, :create, :update]
      end
      ```

    * Next error:  no controller action!  Let's define an update action in our movies controller:

      ```ruby
      def update
      end
      ```

    * Now we get the missing template error.  Let's address that:

        ```ruby
        def update
          movie = Movie.find(params[:id])
          if movie.update(movie_params)
            head 204
          end
        end
        ```

    * That makes our test pass!  Notice that we aren't returning the newly updated movie object in the response body.  We're only sending back a response header with a 204 status code, which is used for a successful request that doesn't have a response body.

    * Another passing test...you're a hero!

9. We're so close to having full CRUD...let's tackle destroying a resource!  As always, we'll start with a test:

    ```ruby
    describe "DELETE request to api/movies/:id" do
        before do
          movie = FactoryGirl.create(:movie)
          @num_movies = Movie.count
          delete "/api/movies/#{movie.id}"
        end

        it "destroys a movie" do
          expect(Movie.count).to eq(@num_movies - 1)
        end

        it "responds with a 204 status code" do
          expect(response).to have_http_status 204
        end
      end
    ```

    * Okay, we've got a failing test!  It says there isn't a route for delete.  Let's take care of that:

      ```ruby
      namespace :api do
        resources :movies, only: [:index, :show, :create, :update, :destroy]
      end
      ```

    * Next error:  no controller action for "destroy".  Let's write it:

      ```ruby
      def destroy
      end
      ```

    * Let's fix that missing template error:

      ```ruby
      def destroy
        head 204
      end
      ```

    * Okay, we get the status code spec to pass, but we need to actually destroy the movie:

      ```ruby
      def destroy
        Movie.find(params[:id]).destroy
        head 204
      end
      ```

    * When we run our test, we see that everything passes. Have a drink...you deserve it!!! 

10. Currently, our API is returning ALL the data from our movie objects to the client.  But maybe we want to limit the data that gets returned. For example, maybe we don't want to include the datetime stamps in our JSON object.  (Another good example of when you wouldn't want to return all the data is on a user model...in that case you likely wouldn't want to send clients the email, address, password digest, etc. That is private information!)

    We can modify the JSON that we send by extending Rails' `as_json` method in our movie model.

    ```ruby
    class Movie < ActiveRecord::Base
      validates :title, presence: true

      def as_json(options={})
        super(:except => [:created_at, :updated_at])
      end
    end
    ```

    Awesome!  Now if we send the following curl request to our API:

    ```
    $ curl -i http://localhost:3000/api/movies
    ```

    We can see that we are only getting back the attributes that we specified when we extended the `as_json` method.
