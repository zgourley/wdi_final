#Building a Rails API: Gorgeous Glenn's Bow Tie Bazaar

##Learning objectives
* Build a Rails API that serves JSON
* Use Rails' resources to generate routes
* Learn how to namespace our API routes
* Review some common HTTP response status codes
* Use the Insomnia REST Client app to send HTTP requests to our API
* Extend Rails' `as_json` method to restrict the data we send to a client

##Roadmap
This morning we are going to be focused exclusively on building an API that will render our data as JSON. In part two of this lesson, Glenn will show us how to consume our API using jQuery.

##Setting up our application
1. Let's get our new app started:
  ```
  $ rails new bowties-api -d postgresql -T
  ```

2. If we spin up our Rails server and try to visit localhost:3000, we get an `ActiveRecord::NoDatabaseError` message. This is one of the differences between working with SQLite vs. PostgreSQL. This error is super easy to fix:

  ```
  $ rake db:create
  ```

3. Last thing:  for some reason, Rails is trying to singularize "bowtie" as "bowty", so we need to fix that in our inflections.rb file, which lives in the config directory.  While we're in there, we can also add a custom inflection for "API":

  ```ruby
    ActiveSupport::Inflector.inflections(:en) do |inflect|
      inflect.irregular 'bowtie', 'bowties'
      inflect.acronym 'API'
    end
  ```

##Building our model
1. Let's get started by generating our model:

  ```
  $ rails g model Bowtie material pattern style image_url wholesale_price:float retail_price:float
  ```

2. Before we forget, let's go ahead and run that migration:
  ```
  $ rake db:migrate
  ```

##Our Routes and Controller Actions
###A list of all our bowties!
1. Here's what we want: we want to be able to send an HTTP GET request to `/api/bowties` and get back a JSON object that contains an array of all the bowties in our database. 

  Let's try to visit that location from our browser and see what happens. No big surprise, we get a routing error that tells us we don't have a route defined (duh!).

  We can fix that!  Because we're building an API, we're going to do write our routes a little bit differently than we has in the past. Let's start by using Rails' `resources` method to generate our routes:

  ```ruby
  resources :bowties
  end
  ```

  First of all, let's check out what that `resources` method did:

  ```ruby
  Prefix Verb   URI Pattern                 Controller#Action
      bowties GET    /bowties(.:format)          bowties#index
              POST   /bowties(.:format)          bowties#create
   new_bowtie GET    /bowties/new(.:format)      bowties#new
  edit_bowtie GET    /bowties/:id/edit(.:format) bowties#edit
       bowtie GET    /bowties/:id(.:format)      bowties#show
              PATCH  /bowties/:id(.:format)      bowties#update
              PUT    /bowties/:id(.:format)      bowties#update
              DELETE /bowties/:id(.:format)      bowties#destroy
  ```

  It automatically built all the routes for CRUD functionality. That's a neat parlor trick, but not exactly what we're looking for.

  Let's start by getting rid of all those extra routes that we don't need right now:

  ```ruby
  resources :bowties, only: [:index]
  ```

  Boom! But remember, we wanted our path to be `/api/bowties`. Rails has a fix for that:

  ```ruby
  namespace :api do
    resources :bowties, only: [:index]
  end
  ```

2. The next error we will get is `ActionController::RoutingError: uninitialized constant API` because we haven't defined a thing called API anywhere--so far, we're just refering to it in our `routes.rb` file. We can fix this error by doing the following:

  * create a directory called "api" inside the controllers directory.
  * inside our "api" directory, create a new file called "bowties_controller.rb".
  * Now we need to write our controller.  It should look like this:

    ```ruby
    module API
      class BowtiesController < ApplicationController
      end
    end
    ```
  
  * "Whoa! Hold the phones...WTF is a module?!", you ask? First, settle down, buster. Modules are #NBD. A module is just a collection of methods and/or constants (and Ruby classes--you know, like Rails controllers--_are_ constants, so there!).

3. Now, if we try to visit `localhost:3000/api/bowties`, we no longer get that `UninitializedConstant API` error message. Instead, it tells us that the index action could not be found for our `API::BowtiesController`. 
 
  You know how to fix that! Take **30 seconds** to make that error go away. 

  ```ruby
  module API
    class BowtiesController < ApplicationController
      def index
      end
    end
  end
  ```

4. The next error we should get is something about a missing template. Remember that a Rails controller's default behavior is to render an HTML view template. But that's not what we want in this case. When someone sends a GET request to `/api/bowties`, we want to respond with json so let's make that happen by adding the following to our controller:

  ```ruby
  module API
    class BowtiesController < ApplicationController

      def index
        render json: Bowtie.all
      end
    end
  end
  ```

  Boom! Now if we visit `/api/bowties`, we get an empty array. Maybe now's a good time to seed our database with some bowties so that we can actually see some data coming back. Let's do this thing:

  Here's some data for our `seeds.rb` file:

  ```ruby
  Bowtie.destroy_all

  bowties = Bowtie.create([
    {material: "silk",
      pattern: "houndstooth",
      style: "slim",
      wholesale_price: "14.98",
      retail_price: "24.95",
      image_url: "http://www.thetiebar.com/database/products/BS178_l.jpg"
    },
    {material: "silk",
      pattern: "floral",
      style: "slim",
      wholesale_price: "14.45",
      retail_price: "23.95",
      image_url: "http://www.thetiebar.com/database/products/BS184_l.jpg"
    },
    {material: "silk",
      pattern: "paisley",
      style: "traditional",
      wholesale_price: "15.65",
      retail_price: "26.95",
      image_url: "http://www.thetiebar.com/database/products/B1735_l.jpg"
    },
    {material: "wool",
      pattern: "plaid",
      style: "diamond tip",
      wholesale_price: "16.48",
      retail_price: "29.95",
      image_url: "http://www.thetiebar.com/database/products/BD325_l.jpg"
    },
    {material: "cotton",
      pattern: "gingham",
      style: "traditional",
      wholesale_price: "14.35",
      retail_price: "22.95",
      image_url: "http://www.thetiebar.com/database/products/BC570_l.jpg"
    },
    {material: "wool",
      pattern: "plaid",
      style: "traditional",
      wholesale_price: "16.48",
      retail_price: "29.95",
      image_url: "http://www.thetiebar.com/database/products/BW147_l.jpg"
    },
    {material: "cotton",
      pattern: "plaid",
      style: "slim",
      wholesale_price: "14.45",
      retail_price: "22.95",
      image_url: "http://www.thetiebar.com/database/products/BS202_l.jpg"
    },
    {material: "cotton",
      pattern: "striped",
      style: "diamond tip",
      wholesale_price: "14.48",
      retail_price: "23.95",
      image_url: "http://www.thetiebar.com/database/products/BD335_l.jpg"
    },
    {material: "silk",
      pattern: "geometric",
      style: "slim",
      wholesale_price: "15.95",
      retail_price: "28.95",
      image_url: "http://www.thetiebar.com/database/products/BT122_l.png"
    },
    {material: "silk",
      pattern: "plaid",
      style: "diamond tip",
      wholesale_price: "18.95",
      retail_price: "34.95",
      image_url: "http://www.thetiebar.com/database/products/BD324_l.jpg"
    }
  ])
  ```

  ```
  $ rake db:seed
  ```
 
  Now if we hit up `/api/bowties` we can see some delicous data. I'm loving where this is going!  

###Getting JSON for just one bowtie
1. Now let's tackle getting our API to return a single bowtie. This should be easy peasy. Let's see what happens when we go to `/api/bowties/1` and see what happens. 

  A `No route matches...` error...no surprise there!  Take **30 seconds** and make that error go away.

  ```ruby
  namespace :api do
    resources :bowties, only: [:index, :show]
  end
  ```

2. The next error is that we don't have a show action in our bowties controller.  We can fix that!

  ```ruby
  #in our bowties_controller.rb file
  def show
  end
  ```

3. That gives us an error saying that the template is missing.  Starting to see a pattern here? We get that error because we haven't told that controller action what to return and Rails isn't able to infer it.  Let's tell it what to do:

  ```ruby
  def show
    render json: Bowtie.find(params[:id])
  end
  ```

  Sweet like bear meat! When we visit `/api/bowties/1` we see some stunningly attractive JSON. Boom! 

###Creating a new bowtie
1. Let's get serious and tackle creating a new bowtie. First thing we need to address is routing. What route do we need? Take **30 seconds** and add the appropriate route to your `routes.rb` file.

  ```ruby
  namespace :api do
    resources :bowties, only: [:index, :show, :create]
  end
  ```

2. Next thing we're going to need? A controller action, of course! 

  ```ruby
  def create
  end
  ```

  Okay, this is going to look pretty similar to the `create` actions we have written in the past, but there are a few differences. 

  ```ruby
  def create
    bowtie = Bowtie.new(bowtie_params)

    if bowtie.save
      render json: bowtie, status: 201, location: [:api, bowtie]
    end
  end

  private
  def bowtie_params
    params.require(:bowtie).permit(:material, :pattern, :style, :image_url, :wholesale_price, :retail_price)
  end
  ```

  Now let's try to create a new bowtie by sending a POST request to our API. We'll use a tool called [Insomnia REST Client](http://insomnia.rest/) to do this.

  To create a new POST request using Insomnia, we'll need to do a few things:

    * select the POST method from the dropdown menu
    * make sure we are posting to `http://localhost:3000/api/bowties` (we can figure out the route to post to by running `rake routes`)
    * we need to give it a payload. Make sure to select the type as `JSON` and then give it a payload like this:
     
      ```json
      {"bowtie": {
          "material": "cotton",
          "pattern": "striped",
          "style": "traditional",
          "wholesale_price": "18.49",
          "retail_price": "28.99"
          }
      }
      ```

  Nice try, buster! Rails isn't going to just let you waltz in here and post data from some other domain. We can see that when we try to submit this POST request, we get back a 422 status code (Unprocessable Entity). This happens because Rails checks the incoming request for an authenticity token if the request is a POST, PUT, PATCH, or DELETE.  

  This is set up as the default for all our controllers in our Application Controller.  It's that line that says `protect_from_forgery with: :exception`. 

  To fix this, we need to add the following line of code in our bowties controller to override this default behavior: `protect_from_forgery with: :null_session`.

  Now, if we try to submit that POST request again, we will see that the POST request is successful and that it returns our newly created bowtie as JSON. Boom!

3. Let's tell our create action what to do if a record doesn't save because of a failed validation.

  Let's start by adding a simple validation to our model so that we can see what happens if a record doesn't save:

    ```ruby
    class Bowtie < ActiveRecord::Base
      validates :pattern, presence: true
    end
    ```

  Now, in our controller we will add an else block to our create action:

    ```ruby
    def create
      bowtie = Bowtie.new(bowtie_params)

      if bowtie.save
        render json: bowtie, status: 201, location: [:api, bowtie]
      else
        render json: bowtie.errors, status: 422
      end
    end
    ```

  Let's try our POST request again and see what happens. We can see that the response includes a `422 Unprocessable Entity` status code and it returns the error messages as JSON (in this case, we get `{"pattern":["can't be blank"]}`). BOOM!

###Updating a bowtie
1. Alright, time to tackle updating a bowtie.

  Okay, no surprise here. We're gonna need a route. Quick: go write it!

    ```ruby
    namespace :api do
      resources :bowties, only: [:index, :show, :create, :update]
    end
    ```

  Next up:  no controller action!  Let's define an update action in our bowties controller:

    ```ruby
    def update
      bowtie = Bowtie.find(params[:id])
      if bowtie.update(bowtie_params)
        head 204
      end
    end
    ```

  Notice that we aren't returning the newly updated bowtie object in the response body.  We're only sending back a response header with a 204 status code, which is used for a successful request that doesn't have a response body.

  But what if an update fails for some reason, like not meeting a validation? We need to add an `else` block in our update action:

    ```ruby
    def update
      bowtie = Bowtie.find(params[:id])
      if bowtie.update_attributes(bowtie_params)
        head 204
      else
        render json: bowtie.errors, status: 422
      end
    end
    ```

  So let's use Insomnia to send a PATCH request that tries to set an existing bowtie's pattern to null. This should fail because of our validation...

  And indeed it does! We get back a 422 along with the error message.  Boom to the shizzle!

###Destroying bowties!
1. We're so close to having full CRUD...let's tackle destroying a resource!  As always, we'll start with a route:

  ```ruby
  namespace :api do
    resources :bowties, only: [:index, :show, :create, :update, :destroy]
  end
  ```

2. Next up:  no controller action for "destroy".  Let's write it:

  ```ruby
  def destroy
    bowtie = Bowtie.find(params[:id])
    bowtie.destroy
    head 204
  end
  ```

  Congratulations, you just built your first full CRUD Rails API!

###Customizing our JSON response
3. Currently, our API is returning ALL the data from our bowtie objects to the client.  But maybe we want to limit the data that gets returned.  For example, maybe we don't want to include the wholesale price or the datetime stamps in our JSON object.  (Another good example of when you wouldn't want to return all the data is on a user model...in that case you likely wouldn't want to send clients the email, address, password digest, etc. That is private information!)

    We can modify the JSON that we send by extending Rails' `as_json` method in our bowtie model.

    ```ruby
    class Bowtie < ActiveRecord::Base
      validates :pattern, presence: true

      def as_json(options={})
        super(:except => [:wholesale_price, :created_at, :updated_at])
      end
    end
    ```

    Awesome!  Now if we hit our `/api/bowties` endpoint we can see that we are only getting back the attributes that we specified when we extended the `as_json` method.

4. Let's see how you can also include the data returned from instance methods in your JSON object.  We'll start by writing a method that gives us a very basic description for each bowtie, based on a few of its attributes:

  ```ruby
  def description
    "This #{pattern} bowtie is made from top quality #{material}."
  end
  ```

    Now if we call `.description` on an instance of the Bowtie class, we should get a string that looks something like "This plaid bowtie is made from top quality cotton."

    To have the return value of our `description` method included in our JSON, we just need to modify the `as_json` method a little bit further:

    ```ruby
    def as_json(options={})
      super(except:  [:wholesale_price, :created_at, :updated_at],
            methods: [:description])
    end
    ```
