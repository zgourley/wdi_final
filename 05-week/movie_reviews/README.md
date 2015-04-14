#Everyone's a Critic: a Rails Movie Review App!

##Learning Objectives
* More practice with Rails fundamentals
* Use Active Record's `has_many` and `belongs_to` relationships
* Explore nested routes
* Use a `form_for` with nested resources
* write an instance method in our `movie` model to create a "virtual attribute"

##Roadmap
We're going to be building a basic movie review app. This lesson will allow us to revisit some Rails fundamentals and explore some new facets that we haven't played with yet.

Let's start by taking a quick look at a finished version of what we're going to build today.

##Data Modeling Our App
Here's our models:  `Movie` and `Review`. Each movie will have a title, a rating, the year it was released, and a brief description. Each review will just have and a body and a score (for now).

The relationship between our models will look like this:

* movies will have many reviews and each review will belong to a movie

##Basic setup
1. Create our new Rails app: `$ rails new movie_reviews --skip-test-unit`

##Creating our Movie model
1. Let's generate our model:

    ```
    $ rails g model Movie title rating year:integer description:text`
    ```

2. Before we forget, let's go ahead and run our migration to create the movies table in our database:

    ```
    $ rake db:migrate
    ```

##Creating our Movies controller, controller actions, routes, and views
1. Let's generate our Movies controller:
  
    ```
    $ rails g controller movies
    ```

2. Let's talk about the controller actions we want our app to have. We aren't going to have full CRUD for movies right now. We'll just have:
    
    * index
    * show
    * new
    * create

3. Now that we know which controller actions we are going to write, let's go ahead and add our method definitions. We'll fill them in as we need them, so these will just serve as placeholders:

    ```ruby
    class MoviesController < ApplicationController
      def index
      end

      def show
      end

      def new
      end

      def create
      end
    end
    ```

4. While we're at it, let's go ahead and write all our routes for movies. We'll need one for each controller action:

    ```ruby
    Rails.application.routes.draw do
      get "movies/" => "movies#index"
      get "movies/new" => "movies#new", as: :new_movie
      post "movies/" => "movies#create"
      get "movies/:id" => "movies#show", as: :movie
    end
    ```

5. Let's give users the ability to add new movies.  We will need to:

    * write the `new` and `create` controller actions

        ```ruby
        #app/controllers/movies_controller.rb
        def new
          @movie = Movie.new
        end

        def create
          @movie = Movie.new(params.require(:movie).permit(:title, :rating, :year, :description))

          if @movie.save
            redirect_to movie_path(@movie)
          else
            render :new
          end
        end
        ```

    * write the view with a form:

        ```html
        <h1>Add a new movie!</h1>

        <%= form_for @movie do |f| %>
            
            <div>
               <%= f.label :title %> 
               <%= f.text_field :title %>
            </div>


            <div>
               <%= f.label :rating %> 
               <%= f.text_field :rating %>
            </div>

            <div>
               <%= f.label :year %> 
               <%= f.text_field :year %>
            </div>

            <div>
               <%= f.label :description %> 
               <%= f.text_area :description %>
            </div>

            <%= f.submit "Add this movie!" %>

        <% end %>
        ```

5. Now that we can create new movies, we will need a `show` controller action and view template to get rid of that error message that we see when we submit our form for a new movie.  Let's:

    * write the `show` controller action:

        ```ruby
        #app/controllers/movies_controller.rb
        def show
          @movie = Movie.find(params[:id])
        end
        ```

    * write the view template:
        
        ```html
        <section>
            <h1><%= @movie.title %></h1>
            <p><strong>Rating:</strong> <%= @movie.rating %></p>
            <p><strong>Year released:</strong> <%= @movie.year %></p>
            <p><strong>Description:</strong> <%= @movie.description %></p>
        </section>
        ```

##Adding reviews to movies

1. First, we'll need a model:  

    ```
    $ rails g model Review body score:integer movie:references
    ```

    Notice how we said `movie:references`? That is going to do two things for us. First, it will add a method to our `Review` model called `belongs_to :movie`. Second, in the migration file that it generates, it will set up a foreign key column for us on the `reviews` table called `movie_id` that holds the id of the movie to which that review belongs.

    BTW, don't forget to run your migration!

    ```
    $ rake db:migrate
    ```

    Before we move on, let's open up our database GUI to take a look at this new `reviews` table that got created.

2.  We'll also want to go ahead and set up the other side of this relationship:

    * in the Movie model: `has_many :reviews`

3.  Time to add a controller:  `$ rails g controller Reviews`

4.  Let's talk about the controller action(s) we want for comments:

    * create

5.  Now that we know we only need a `create` action, let's set up our routes.  We are going to nest the movies create route inside the movies show route:

    ```ruby
      post "movies/:id/reviews" => "reviews#create", as: :movie_reviews
    ```

    Let's see how our routes are being created by running `$ rake routes`

6. Let's create a few new reviews in our Rails console to see how we can access reviews that belong to a movie.

7. Before we write the create action in our reviews controller, let's add one thing to our movie show view: a list out every review that belongs to a movie.

    ```html
    <section>
        <h2>Reviews</h2>

        <% @movie.reviews.each do |review| %>
            <div>
                <h3>Review #<%= @movie.reviews.index(review) + 1 %></h3>
                <p><strong>Score:</strong> <%= review.score %></p>
                <p><strong>The verdict:</strong> <%= review.body %></p>
            </div>
        <% end %>
    </section>
    ```


8. Now, let's add a form to our movie show view that will allow us to create a new review. 

    ```html
    <section>
        <h2>Add a new review!</h2>
        <%= form_for [@movie, @review] do |f| %> 
           
            <div>
                <%= f.label :body, "Review" %> 
                <%= f.text_area :body %>
            </div>

            <div>
                <%= f.label :score %> 
                <%= f.number_field :score %>
            </div>

            <%= f.submit "Add your review!" %>

        <% end %>
    </section>
    ```

    Notice how we are passing a string to the second argument to the `f.label` method call. That allows us to customize the inner text of the label that gets generated by Rails.

    This form won't work yet, though.  We will need to do some work in our controllers to get this form to work.

9. The first thing we need to do to get our form working is to add an instance variable for a new Review object in our movies controller: `@review = Review.new`.  Now the page will render, but it won't create a new review until we write the create action in our comments controller.

10. Here's the create action in our reviews controller:

    ```ruby
    def create
      @movie = Movie.find(params[:id])
      @review = @movie.reviews.new(params.require(:review).permit(:body))
      @review.save
      redirect_to movie_path(@movie)
    end
    ```
    * First, we retrieve the movie object to which the new review will belong.
    * Next, we create our new review through the movie object
    * Finally, we redirect back to the movie show view

##Creating a virtual attribute with an instance method
Our last challenge is to calculate an average score for each movie, based on the scores given by reviewers. To do this, we will write an instance method in our `Movie` model that will allow us to say `@movie.average_score` and get back the average score. This will behave much like all the other attributes of our model, but this value won't be saved to the database. Rather, it will be calculated everytime our movie show view is loaded. For this reason, we'll call `average_score` a "virtual attribute".

1. Let's start by adding the code to our movie show view:

    ```html
    <!-- app/views/movies/show.html.erb -->
    <p><strong>Average score:</strong> <%= @movie.average_score %></p>
    ```

    Of course we don't have an attribute called `average_score` yet, so we'll get an error when we try to load the movie show view. To fix this, we'll go write a method in our Movie model.

2. Let's write an instance method in our Movie model:

    ```ruby
    #app/models/movie.rb
    def average_score
      if self.reviews.count > 0
        sum = 0
        num_scores = 0

        self.reviews.each do |review|
          if review.score
            sum += review.score
            num_scores += 1
          end
        end

        sum/(num_scores.to_f)
      else
        "This movie hasn't been scored yet."
      end
    end
    ```

    Now whenever we call `.average_score` on an instance of our Movie model, we will get back an average score of all the reviews or, if no scores have been given yet, we'll get back a string saying "This movie hasn't been scored yet.".

    This is a good start, but it has some performance issues. Let's refactor this:

    ```ruby
    class Movie < ActiveRecord::Base
      has_many :reviews

      def average_score
        if self.reviews.count > 0
          self.reviews.where.not(score: nil).average("score")
        else
          "This movie hasn't been scored yet."
        end
      end
    end
    ```
