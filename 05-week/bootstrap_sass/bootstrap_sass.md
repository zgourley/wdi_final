#BOOTSTRAP & SASS

#Bootstrap

Lesson objectives:

	1. Understand Bootstrap and what it does
	2. Understand the grid system
	3. Create a responsive website

Why use Bootstrap?

Preprocessors:
	
	Bootstrap ships with vanilla CSS, but its source code utilizes the two most popular CSS preprocessors, Less and Sass. Quickly get started with precompiled CSS or build on the source.
	
One framework, every device.

	Bootstrap easily and efficiently scales your websites and applications with a single code base, from phones to tablets to desktops with CSS media queries.
	
Full of features

	With Bootstrap, you get extensive and beautiful documentation for common HTML elements, dozens of custom HTML and CSS components, and awesome jQuery plugins.


##Grid system

	Bootstrap grids a page by 12 components
	
	col-xs-(number) = extra small screens (mobile phones)
	col-sm-(number) = small screens (tablets)
	col-md-(number) = medium screens (some desktops)
	col-lg-(number) = large screens (remaining desktops)
	hidden-(xs, sm, md, lg)


###If you're a front-end developer, you can use bower to install bootstrap

	$ bower install bootstrap

Or include Bootstrap CDN links:

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
	
	<!-- Latest compiled and minified JavaScript -->bo
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

And use [Grunt](http://gruntjs.com/) as your task runner for repetitive tasks

If you're using rails:

Start with:

	rails new bootstrap-lesson
	
Add this to your gemfile:

	gem 'bootstrap-sass', '~> 3.2.0'

Then

	bundle install


Create a StaticPagesController

	rails g controller StaticPages home about shop testimonials

Change the route to
	
	root 'static_pages#home'
	

Then

	// app/assets/stylesheets/application.css.scss


	@import "bootstrap-sprockets";
	@import "bootstrap";

Include `//= require bootstrap-sprockets` to `app/assets/javascript/application.js`

	

	// app/assets/javascripts/application.js
	
	//= require jquery
	//= require jquery_ujs
	//= require turbolinks
	//= require bootstrap-sprockets
	//= require_tree .


***Add Viewport to application.html.erb***

```
* This ensures proper rendering and touch zooming on mobile devices.

<meta name="viewport" content="width=device-width, initial-scale=1">
```
  

***The home.html.erb***

```
<div class="container-fluid">

  <div class="masthead">
      <h3 class="text-muted">Coffeeshop</h3>    
  </div>

  <!-- Jumbotron -->
  <div class="jumbotron">
    <h1>Glenn's Special Blend Coffee</h1>
    <p class="lead">The best coffee on the West Coast. Order 5 and get one free today!</p>
    <p><%= link_to "Buy today", root_url, class: 'btn btn-lg btn-success' %></p>
  </div>

  <!-- Example row of columns -->
    <div class="row">

        <div class="col-lg-4">

          <h2>How good is the coffee?</h2>
          <p class="text-danger">Warning!</p>
          <p>This coffee is so good that you will never want to drink any other brew again! We have a 100% satisfaction guarantee, if you are not satisfied, we will return your money no question asked.</p>
          <p><%= link_to "Read testimonials", '#', class: "btn btn-primary" %></p>
        </div>



        <div class="col-lg-4">
          <h2>About</h2>
          <p>Our family heritage is deeply ingrained from the city of London. We began brewing coffee since the days of King George III. We have maintained a culture of excellent since 1738.</p>
          <p><%= link_to "See our history", '#', class: "btn btn-primary" %></p>
       </div>


        <div class="col-lg-4">
          <h2>Buy</h2>
          <p>Shop through a wide selection of our products. We offer the finest coffee in the world. As our tagline goes: "We're not too expensive, you're too cheap."</p>
          <p><%= link_to "Shop now", '#', class: "btn btn-primary" %></p>
        </div>


    </div>

    <!-- Site footer -->
      <footer class="footer">
        <p>&copy; Company 2014</p>
      </footer>

</div>
```


Activity:

	In group of 3, create the testimonials, about, shop pages
	
---

#SASS

Stands for: `Syntactically Awesome Style Sheets`

	SASS is a CSS extension language. It allows users to utilize features that don't current exist in CSS. You can use:
	
	- variables
	- nesting
	- mixins
	
	Your preprocessed Sass (.scss) file is saved as normal CSS that is utilized on the web site.

##Variables


Think of variables as a way to store information that you want to reuse throughout your stylesheet. You can store things like colors, font stacks, or any CSS value you think you'll want to reuse. 

	$font-stack:    Helvetica, sans-serif;
	$primary-color: #333;
	
	body {
	  font: 100% $font-stack;
	  color: $primary-color;
	}

##Nesting

Sass will let you nest your CSS selectors in a way that follows the same visual hierarchy of your HTML. Be aware that overly nested rules will result in over-qualified CSS that could prove hard to maintain and is generally considered bad practice.

```
section{
  ul {
  margin: 0;
  padding: 0;
  }

  li {
    display: inline-block;
  }

  a {
    display: block;
    padding: 6px 12px;
    text-decoration: line-through;
  }

}
```
	
would be the equivalent of

```
section ul {
  margin: 0;
  padding: 0;
}

section li {
  display: inline-block;
}

section a {
  display: block;
  padding: 6px 12px;
  text-decoration: line-through;
}
```

##Mixins

Mixin in programming is a special kind of multiple inheritance. You use it when:

- You want to provide a lot of optional features for a class
- You want to use one particular feature in a lot of different classes


```
@mixin border-stuff($radius) {
  border: 1px solid green;
  -webkit-border-radius: $radius;
  -moz-border-radius:    $radius;
  -ms-border-radius:     $radius;
       border-radius:    $radius;
    }
		
.box { @include border-stuff(10px); }
		
```