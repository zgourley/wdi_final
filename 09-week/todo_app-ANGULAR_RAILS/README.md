#Angular + Rails: The Todo App Revisited!

##Learning Objectives
* More practice building a JSON API with Rails
* Consume a Rails API using Angular and `$http`
* Configure Rails to allow cross-origin resource sharing (CORS)

##Roadmap
Today marks a momentous event in our lives as WDI'ers. Today, Angular and Rails join forces in what will almost certainly result in a spectacular display of web development prowess that will blow your mind!

Okay, okay...maybe I've overstated it just a _little_ bit. But, what we learn today will definitely introduce you to a powerful combination of technologies: Rails as a JSON API and Angular as the front-end client.

In our three-hour introduction, we will focus on the building blocks of how to set up separate client and server-side apps. We are going to use our Angular todo app from week 2 (remember that one?!) as our starting point. By the end of the lesson, we will have basic, full CRUD functionality. We aren't going to be tackling things like user authentication today...that's coming up in a future lesson.

##Getting Started
1. The first thing we are going to need is a Rails app.  Let's `rails new` this thing!

  ```
  $ rails new rails-todo-api -T -d postgresql
  ```

2. We're using Postgres, so let's go ahead and create our database:

  ```
  $ rake db:create
  ```

3. Since we are going to be namespacing our API, let's make sure that we update our `inflections.rb` file:

  ```ruby
  ActiveSupport::Inflector.inflections(:en) do |inflect|
    inflect.acronym "API"
  end
  ```

Setup done. Boom!

##Retrieving the list of all todos
Let's start by building the ability for our Angular client to retrieve the list of all todos from our Rails API. In other words, we want to be able to send an HTTP GET request to our Rails server at `/api/todos` and get back all of our todos from the database as JSON.

###The Rails side of things
1. Let's start by creating a Todo model. We can use our original Angular app as a guide for the attributes that our todos should have. We'll keep it simple and mirror the Angular app exactly:

  ```
  $ rails g model Todo task:string done:boolean
  ```

2. Of course that made a migration file for us, so let's run that shiz:
  
  ```
  $ rake db:migrate
  ```

3. Now that we've got our model, let's move on to setting up our first route:

  ```ruby
  namespace :api do
    resources :todos, only: [:index]
  end
  ```

4. Let's go ahead and make a new `api` directory for our controllers and make our `todos_controller.rb` file inside that directory:

  ```
  $ mkdir app/controllers/api
  $ touch app/controllers/todos_controller.rb
  ```

5. Let's get the basics of our `todos_controller.rb` file set up:

  ```ruby
  module API
    class TodosController < ApplicationController
    end
  end
  ```

6. I think we're ready for that index action now!

  ```ruby
  # app/controllers/api/todos_controller.rb
  def index
    render json: Todo.all
  end
  ```

  Now if we go to `/api/todos`, we should see an empty array. Boom!

7. Let's add some seed data to our Rails app so that we've got some todos to see right now:

  ```ruby
  Todo.destroy_all

  Todo.create([
    {task: "build an awesome API for our todo app", done: false},
    {task: "get super good at Angular", done: false},
    {task: "party on code", done: false},
    {task: "tackle a bonus challenge and write tests for this app", done: false},
    {task: "take a nap", done: false}
  ])
  ```

  To add these to our database, we just need the help of `rake db:seed`. If we revisit `/api/todos` we can now see that data. Sweet! Let's make the switch in our Angular app to pull our todos from our API instead of from the hard-coded array we currently have.

###The Angular side of things
1. We want to be able to have our Angular app make HTTP requests to our Rails server, so the first thing we need to do is inject the `$http` service into our Angular controller. It should look something like this:

  ```javascript
  angular
      .module("todoApp")
      .controller("TodosController", TodosController);

      TodosController.$inject = ["$http"];

      function TodosController($http){
        //controller code omitted for brevity
      }
  ```

2. Currently, `self.todoList` is equal to a hard-coded array...lame! Let's write a function called `getTodos()` and assign that function call to `self.todoList`:

  ```javascript
  self.todoList = getTodos();

  function getTodos(){

  }
  ```

3. Okay, let's write the body of that function to make an HTTP request to our Rails server. For now, we'll just `console.log` the response.

  ```javascript
  //function that retrieves todos from Rails API
  function getTodos(){
      $http.get("http://localhost:3000/api/todos").
          success(function(response){
              console.log(response);
          }).
          error(function(response){
              console.log(response);
          });
  }
  ```

4. Let's go take a look at our Angular app in our browser and see what's going on. For now, let's also go ahead and comment out the `<header>` in our `index.html`--this will prevent us from seeing a bunch of errors in our console about trying to call `.length` on `undefined`.

  Okay, when we load the page in our browser and take a look at our console, we see the following error message:

  ```
  XMLHttpRequest cannot load http://localhost:3000/api/todos. 
  No 'Access-Control-Allow-Origin' header is present on the requested resource. 
  Origin 'null' is therefore not allowed access.
  ```

  Here's the deal: by default, we can't make cross-domain AJAX requests. To remedy this, we need to do some configuration to our Rails app to allow AJAX requests from other domains.

5. We are going to use a gem called `Rack CORS Middleware` to help us handle cross-origin resource sharing (CORS). Let's add the gem to our Gemfile:

  ```ruby
  gem 'rack-cors', :require => 'rack/cors'
  ```

  Don't forget to bundle!

  ```
  $ bundle install
  ```

6. Now that we've got the `rack-cors` gem installed, we are going to configure some things in our `application.rb` file:

  ```ruby
  config.middleware.insert_before 0, "Rack::Cors" do
    allow do

      origins "*"

      resource "/api/*",
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options]
    end
  end
  ```

  If we reload our Angular app (you'll probably need to do a "hard reload", which you can do by holding down the reload button on your browser and then selecting "hard reload"), we'll see that the data is now being retrieved and logged to our console.

  Let's break down what we just did with that Rails configuration:

  * We call `config.middleware.insert_before 0`, which adds `Rack::Cors` to the top of the middleware stack
  * `origins` refers to the domains we will accept requests from. In this case, we are accepting requests from any domain (this would be useful if we were building a public, open API). We could change this from `"*"` to only allow a specific domain.  For example, we could change it to `http://localhost:8080` and serve our Angular app using `http-server` on port 8080. Then, if we tried to serve our Angular app on a different port, we would  see that we get that `cross-domain` error again.
  * `resource` refers to the routes that we are allowing to be accessed by an outside domain: in this case, everything that begins with `/api`.
  * `headers` refers to the HTTP headers that will be allowed in the CORS request. `:any` is the default that is used in the documentation, so it's what we're going to stick with.
  * `methods` is an array of the HTTP methods we will allow.

  I know that's a lot of information. If you want to learn more, there are some links to additional resources at the bottom of this README.

7. Okay, now that we are able to successfully retrieve our list of todos from our Rails API, we can assign the array that comes back to `self.todoList`. We'll do this inside the `.success` callback of our `getTodos()` function:

  ```javascript
  function getTodos(){
      $http.get("http://localhost:3000/api/todos").
          success(function(response){
              self.todoList = response;
          }).
          error(function(response){
              console.log(response);
          });
  }
  ```

  This shows us a list of all our todos...hellz yes!

##Adding a new todo to the list
Now we want to submit a POST request from our Angular app to our Rails API that saves a new todo to the database.

###The Rails side of things
1. First up, we need a route (but you already knew that!):

  ```ruby
  namespace :api do
    resources :todos, only: [:index, :create]
  end
  ```

2. Next up: controller action!

  ```ruby
  def create
    todo = Todo.new(todo_params)

    if todo.save
      render json: todo, status: 201
    else
      render json: todo.errors, status: 422
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:task, :done)
  end
  ```

3. While we're at it, let's add a model validation that will prevent a todo from being created if an empty task is submitted:

  ```ruby
  class Todo < ActiveRecord::Base
    validates :task, presence: true
  end
  ```

4. The last thing we need to do on the Rails side is to change the way we protect from forgery in our `todos_controller.rb` file:

  ```ruby
  protect_from_forgery with: :null_session
  ```

  Oh snap...we just set the table for Angular to be able to POST to our Rails API!

###The Angular side of things
1. Alright, we need to make a change to our `addTodo()` method. Now, instead of just pushing an object into a local array, we need to submit a POST request to our Rails API and then add the todo to our client-side array of todos when we get back a success. That should look something like this:

  ```javascript
  function addTodo(){
      var newTodo = {task: self.text, done: false};

      $http.post("http://localhost:3000/api/todos", {todo: newTodo}).
        success(function(response){
          console.log(response);
        }).
        error(function(response){
          console.log(response)
        });
  }
  ```

  The `$http.post` method is a lot like the `$http.get` method. The only difference in how we are using it is that we are passing in an additional argument: the data that we want to submit to our API (duh!).

  If we reload our Angular app and try to add a new todo, we can see that the object gets logged to our console after we get a successful response from the server. Sweet!

2. Currently our new todo isn't showing up on our list. We have to reload our page to see it. Lame! But that's an easy fix. We just need to push it onto our `todoList` array in that `.success` callback:

  ```javascript
  function addTodo(){
      var newTodo = {task: self.text, done: false};

      $http.post("http://localhost:3000/api/todos", {todo: newTodo}).
        success(function(response){
          self.todoList.push(response);
        }).
        error(function(response){
          console.log(response)
        });
  }
  ```

  While we're at it, let's make sure that we clear out that text box, too. Because that's something that we want to happen whether the POST request is successful or not, we will add that outside of the callbacks:

  ```javascript
  function addTodo(){
      var newTodo = {task: self.text, done: false};

      $http.post("http://localhost:3000/api/todos", {todo: newTodo}).
        success(function(response){
          self.todoList.push(response);
        }).
        error(function(response){
          console.log(response)
        });

      self.text = null;
  }
  ```

3. The last thing we want to do here is see what happens when we try to submit an empty todo. We can see in our browser console that we get back an object that contains a property called `task`, which in turn holds an array of error messages. 

  It would be a good idea to have some kind of logic in our Angular app to deal with these error messages and provide some kind of feedback to the user. I'll leave that as an exercise for the reader.

##Marking a todo as done
Our next challenge is to build the ability for us to mark a todo as "done" in our Angular app and have that information updated in the database. Let's do this thing!

###The Rails side of things
1. No surprise here, our API needs a route for handling updates!

  ```ruby
  namespace :api do
    resources :todos, only: [:index, :create, :update]
  end
  ```

2. Our route's no good without a controller action. Let's go write it:

  ```ruby
  def update
    todo = Todo.find(params[:id])

    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end
  ```

  Easy peasy! It's time to update our Angular controller.

###The Angular side of things
1. In our original Angular app, we never wrote a function for updating a todo's status to done. That's because we were simply binding that value of a todo's `done` property to the value of a checkbox using the `ng-model` directive. When one changed, the other changed accordingly.

  Now that we have an API we want to tell about any changes to a todo, we're gonna need a function that makes an HTTP request back to our Rails server each time the checkbox is clicked. No problemo...we got this!

  Let's take this slow. We'll start by just writing a function that will `console.log` the value of a todo's `done` property every time we click the checkbox.

  ```javascript
  // our Angular TodosController.js file

  self.updateTodo = updateTodo;

  function updateTodo(todo){
    console.log(todo.done);
  }
  ```

  Now, if we want to actually call this function when the box is clicked, we need to attach an event listener to the checkbox in our view using the `ng-click` directive:

  ```html
  <input class="checkbox" type="checkbox" ng-model="todo.done" ng-click="todos.updateTodo(todo)">
  ```

  We can see if it is working by reloading our `index.html` page, open our console, and click any one of the checkboxes repeatedly. We should see `true` or `false` in our console on each click.

2. That's a good start, but obviously if we refresh our page we lose that data about whether a todo is done or not. To fix that, we need to send a PATCH request back to our Rails server with the updated information.
  
  Let's update our `updateTodo()` function:

  ```javascript
  function updateTodo(todo){
    $http.patch("http://localhost:3000/api/todos/" + todo.id, {todo: todo}).
      success(function(response){
        console.log("update successful!");
        console.log(response);
      }).
      error(function(response){
        console.log(response);
      });
  }
  ```

  Now when we refresh our page and open our console, we can see that each time we submit a PATCH request we are getting back the updated object with the new value for `todo.done` correctly modified. Boom! 

  Likewise, we can see the successful PATCH request happening by looking at our Rails server logs. Neat-o! 

##Deleting a todo
We're so close to having full CRUD on this API... Let's add the ability to delete a todo from the database!

###The Rails side of things
1. I know I'm starting to sound like a broken record, but...we're gonna need a route for this.

  ```ruby
  namespace :api do
    resources :todos, only: [:index, :create, :update, :destroy]
  end
  ```

2. If you've been paying attention (and I know that you have!), then you know that we need a controller action to take care of deleting a todo. That's not too hard. Let's write it:

  ```ruby
  def destroy
    todo = Todo.find(params[:id])
    todo.destroy

    head 204
  end
  ```

  Notice here that after we call `.destroy` on the todo, we call `head 204`. The 204 status code stands for "no content", meaning that we successfully destroyed the record that you asked us to and we don't have any content to send back to you as a result of destroying that record.

###The Angular side of things
1. Our original Angular app already had a `deleteTodo()` function, so we just need to tweak it a little to make it talk to our Rails API:

  ```javascript
  function deleteTodo(todo){
    $http.delete("http://localhost:3000/api/todos/" + todo.id).
      success(function(response, status){
        console.log("HTTP status code: " + status);
        self.todoList.splice(self.todoList.indexOf(todo), 1);
      }).
      error(function(response){
        console.log(response);
      });
  }
  ```

  Notice in this case, we are passing two arguments to the `success` callback: `response` and `status`. That status argument was available for all of the other `$http` methods we have already used, we just didn't need it until now. In the case of our `delete` request, remember that a successful `destroy` action doesn't return a response body, only headers and a status code of 204. Passing `status` as an argument to the `success` callback is how we can see that status code in our console.

  The other thing that we should point out is that we changed the parameter that our `deleteTodo` function accepts. Now the function expects to receive a whole object, rather than just an index value. We'll need to make a change to how we are calling this function in our `index.html`:

  ```html
  <button class="btn btn-delete" ng-click="todos.deleteTodo(todo)">x</button>
  ```

  And now we should be able to permanently delete todos from our database. Looks like my schedule just got a whole lot lighter...wink! ;)

##Bonus Challenges
Looking for more?  Here's a few bonus challenges for your enjoyment:

* Implement a strategy in Angular for handling errors (like a todo not being successfully created) that provides some kind of feedback to the user, like displaying an error message
* We have a server-side validation in place that prevents a new todo from being created if `task` is empty. Implement some client-side validation that catches this before the form is actually submitted to the server and prevents a user from submitting a form that has an empty task.
* Refactor the implementation that is causing all those error messages when our `<header>` is uncommented. Make sure that your solution is as DRY as possible.
* Implement the ability to edit a todo's task inline that will trigger a PATCH request back to the server

##Cross-Origin Resource Sharing (CORS) Resources:
* A good, detailed [introduction to CORS](http://www.html5rocks.com/en/tutorials/cors/)
* The documentation on the [Rack::Cors gem](https://github.com/cyu/rack-cors)
* A good [blog article](http://dev.housetrip.com/2014/04/17/unleash-your-ajax-requests-with-cors/) on how CORS works with AJAX
* An article from Mozilla on the [same-origin policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)
* An article from Mozilla on [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
