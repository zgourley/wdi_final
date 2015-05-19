#Pagination Station: AJAX-ified!

##Learning Objectives
* Learn some techniques for applying a little more polish to the UX of your app
* Hand roll some basic pagination
* AJAX-ify our pagination...the Rails way!

##Adding Pagination
Here's the goal:  we want to display 10 books at a time and when we go to the next "page", we want to see the next 10 books.

###Basic, hand-rolled pagination
1. Let's start by only displaying 10 books at a time.  That's pretty easy.  ActiveRecord has a `limit` method:

  ```ruby
  def index
    @books = Book.limit(10)
  end
  ```

  Now, when we reload our page, we only see the first 10 books. Boom!

2. That's a good start, but it always returns the first 10 books. Lame! We want to be able to move from page to page to see the other books on the list. This sounds like a job for ActiveRecord's `offset` method:

  ```ruby
  def index
    @books = Book.limit(10).offset(10)
  end
  ```

  Booyah! This gives us the next 10 in the list (i.e. books 11 - 20). We're getting closer but hard-coding the offset will always return books 11 - 20.

3. Let's finish off this pagination business by doing a little math. Here's our strategy: we'll have the user request which page of records they want via a query string in the URL (something like: `localhost:3000/books?page=2`).  We can grab that page number from the URL (it will be in the `params` hash) and do a little math to correctly calculate the offset:

  ```ruby
  def index
    offset_value = (params[:page].to_i - 1) * 10
    @books = Book.limit(10).offset(offset_value)
  end
  ```

  We have to cast `params[:page]` to an integer because it comes in as a string. Now our pagination works. Hellz yes!

  Currently, we don't have any links to navigate our pagination. We have to type our request into the address bar of our browser. This is inherently weak sauce and we want to fix it. 

  We could handroll this too, but...there is a pretty handy gem called `will_paginate` that makes it super easy to deal with pagination and even has nifty view helpers for generating navigation links. Let's check it out! 

###Pagination using the `will_paginate` gem
1. First things first: let's add the gem to our Gemfile.

  ```ruby
  gem 'will_paginate', '~> 3.0.6'
  ```

  Don't forget to bundle that shiz!

2. Using this in our controller to get our list of books is dead simple:

  ```ruby
  def index
    @books = Book.paginate(page: params[:page], per_page: 10)
  end
  ```

  We call the `paginate` method--which comes from the `will_paginate` gem--and we pass it an options hash specifying the page number we want (this will still come from the `params`) and the number of books per page.

###Adding and Styling our links
1. This is awesome. Let's take advantage of the awesome view helper to make some navigation links:

  ```html
  <!-- app/views/books/index.html.erb -->
  <%= will_paginate @books %> 
  ```

  Are you kidding me?! Is it really that easy?! Yes, yes it is.

2. Let's add a little bit of baller styling to it using Bootstrap. To do that, we first need to add the `will_paginate-bootstrap` gem to our Gemfile:

  ```ruby
  gem 'will_paginate-bootstrap'
  ```

  This gem has `will_paginate` as a dependency, which means that we can comment out or remove the `will_paginate` gem.

3.  Now we just need to make a little change in our `index.html.erb` file:

  ```html
  <!-- app/views/books/index.html.erb -->
  <%= will_paginate @books, renderer: BootstrapPagination::Rails %>
  ```

4. The `will_paginate` gem also has a view helper for displaying which entries are currently being displayed:

  ```html
  <!-- app/views/books/index.html.erb -->
  <%= page_entries_info @books, model: "books" %>
  ```

##AJAX-ifying our Pagination
Currently, when we click a link to get a new page of books the url changes and our whole page reloads. It might not look like the whole page is reloading, but it is. We can see this in our server logs or by doing something like displaying the current time in our view using something like `<%= Time.now %>`.

It's not very noticeable in our app because the page is pretty simple and it loads quickly. But imagine if we had lots of elements on this page and the only thing we wanted to change was the list of books.

Enter AJAX!

1. Let's start by creating a new JavaScript file where we can write the code to handle our AJAX requests. Make a file called `pagination.js` inside the `app/assets/javascripts` directory.

2. Let's write a quick test to make sure that our script file is working:

  ```javascript
  // app/assets/javascripts/pagination.js

  $(document).on('page:change', function(){
    alert("Page is loaded!");
  });
  ```

  Notice that `'page:change'` business? That's because Rails uses a thing called Turbolinks and jQuery's normal `$(document).ready()` doesn't play nice with Turbolinks. You can read more about [Turbolinks' custom events here](https://github.com/rails/turbolinks).

2. Now that we know that our jQuery is hooked up, let's do more than just pop up an alert box. What we want to do is attach click event handlers to every pagination link that will submit an AJAX `GET` request back to the server whenever the link is clicked. It should look something like this:

  ```javascript
  $(document).on('page:change', function(){
      $('.pagination a').on('click', function(event){
          $.get(this.href, null, null, 'script');
          event.preventDefault();
      })
  });
  ```

  We're targeting all of the pagination links using a `descendant` selector. We are grabbing all the `<a>` tags that descend from elements with the `pagination` class. Then we attach a click event handler to each one that makes an http `GET` request. 

  The url that we pass in as the first argument is whatever is in the `href` attribute of the link that gets clicked. We are passing the second and third arguments as `null` because we don't need them but we want to make sure to pass the fourth argument, which represents the type of data we expect to be returned from the server. In this case, we are expecting the server to send back JavaScript that will get executed on the client when it is returned.

  The last thing we do is call `event.preventDefault()`. That is to keep the link from behaving as it normally would and taking us to a new page. Remember, we want to stay on the current page and just load in new data.

3. Okay, now we want to tell our Rails controller how to deal with this AJAX request. We can do that by using a `respond_to` block inside that index action:

  ```ruby
  def index
    @books = Book.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end
  ```

  By convention, we called the parameter that we pass into the block `format`. Inside this block, we specify all the request types that we will respond to. If we don't specify anything specific, Rails will try to render a corresponding file type with the name "index" (`index.html.erb` or `index.js.erb`, respectively).

4. We don't have an `index.js.erb` page yet, so let's make one now. We'll start by doing something simple to make sure that it works. Let's just `console.log` a message:

  ```javascript
  console.log("Shawn is awesome!");
  ```

  Obviously that doesn't do anything useful, but it does illustrate that we can send new JavaScript code to the browser and that it will be executed when it arrives. This is going to be very helpful!

  Here's what we want to put inside that `index.js.erb`:

  ```javascript
  $("#books-list").html("<%= escape_javascript(render "books") %>");
  ```

  Using jQuery, we select the `<div>` on the page that has an id of "books-list". Then we call the `.html()` method on that element. When you pass html into the `.html()` method, it replaces the existing html inside that element with whatever you pass in as the argument.

  To put html in their we use the `render "books"` method call, which will render an html partial called `books`--we'll need to make that partial in just a minute. We use the `escape_javascript` method to escape carriage returns and single and double quotes that result from the `render "books"` method call.

5. To make this work, we need to refactor our views and partials a little bit. First thing we need to do is create a partial called `_books.html.erb`. After we make that file, we'll move our pagination links and our `<%= render @books %>` method call into that partial. It should look like this:

  ```html
  <!-- app/views/books/_books.html.erb -->
  <div class="text-center">
      <%= will_paginate @books, renderer: BootstrapPagination::Rails %>
  </div>

  <div class="text-center">
      <%= page_entries_info @books, model: "books" %>
  </div>

  <%= render @books %>
  ```

  Now, inside the `<div>` with the id "books-list", we will render our new books partial instead of rendering `@books`:

  ```html
  <!-- app/views/books/index.html.erb -->
  <div id="books-list">
    <%= render "books" %>
  </div>
  ```

6. We're so close! If we reload our page and click on the first link...it works! No page reload. But...(there's always a "but"!), if we click the link again, it doesn't work anymore. It fully reloads the page. That's because the event listeners aren't being added to the new elements that are being added to the page. 
 
  This is an easy fix. We need to cruise back over to our `pagination.js` file and make one small change. We'll change `'page:change` to `'page:update` and we'll be in business:

  ```javascript
  $(document).on('page:update', function(){
      $('.pagination a').on('click', function(event){
          $.get(this.href, null, null, 'script');
          event.preventDefault();
      })
  });
  ```

  Reload the page and try again. Does it work? Of course it does!

7. Let's give this thing just a little bit more polish. Let's have the new list items fade in instead of just abruptly changing. jQuery makes that pretty easy:

  ```javascript
  // app/views/books/index.js.erb

  $("#books-list").html("<%= escape_javascript(render "books") %>").fadeIn();
  $("#books-partial").hide().fadeIn("slow");
  ```

  Don't forget to add an id called "books-partial" inside our `_books.html.erb` file:

  ```html
  <div id="books-partial">
      <%= render @books %>
  </div>
  ```

  Now we've got a gorgeous fade...just like my 7th grade haircut. Boom!

8. Because we are working in development and our app is being served locally, the data comes back really quickly. But when our app is out on the internet, things might now come back quite so quickly. This is where it can be really helpful to give users some feedback about what's happening. A loading spinner can do this job for us!

  Let's start by simulating a slow page load. Let's add `sleep 2` to the top of the index action in our Books Controller.  Now, if we reload the page and click a link, we can see that nothing happens right away.

  To add a spinner to our page, the first thing we need is...a spinner! Let's use an animated gif because they are super easy to work with. Because the asset pipeline is the bomb, we can just put this thing inside our `app/assets/images` directory and then display it in the view using the `image_tag` helper method. Because I'm awesome, I already put one in the starter code for you (you're welcome).

  Let's add it to our `_books.html.erb` partial:

  ```html
  <div id="spinner" class="text-center">
      <h4 class="text-primary">Getting more great books for you...</h4>
      <%= image_tag "ajax-loader.gif" %>
  </div>
  ```

  Now if we refresh the page, we can see our loading spinner. This is a good start but we really only want it to display during the times that we are fetching data and waiting for it to come back. That's easy! We just need to update our `pagination.js` file to handle this:

  ```javascript
  $(document).on('page:update', function(){
      $('#spinner').hide();

      $('.pagination a').on('click', function(event){
          $('#books-partial').hide();
          $('#spinner').show();
          $.get(this.href, null, null, 'script');
          event.preventDefault();
      })
  });
  ```

  And now that bizness just works. Sweet!