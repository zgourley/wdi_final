#AngularJS Directives

##Learning Objectives
* Learn how to set up an Angular app
* Understand what directives are and what they do
* Learn how to use some of the core built-in Angular directives 

##What are directives and what do they do?
Directives are Angular's way of adding behavior to the DOM.

##AngularJS Style Guide
[John Papa's **excellent** Angular Style Guide](https://github.com/johnpapa/angular-styleguide)

##Built-in directives we are covering today
* ngApp
* ngController
* ngClick
* ngShow
* ngHide
* ngRepeat

##Getting a basic Angular app started
1. Let's start by giving our HTML page a title: something like "Intro to Angular!"
2. We need to add the Angular source code to our project. Let's grab it [here](https://angularjs.org). Make sure to grab the **un-compressed** version!
  Now we need to source in the file to our index.html using a `<script>` tag.

3. Here's where we will make use of our first directive: `ngApp`. This will get added to the `<body>` tag of our HTML page. This is the thing that allows us to use Angular in our HTML page. It is like the granddaddy Angular directive. Without this, Angular will not run on our page.
4. This is the stage at which I like to check to see if I have everything wired up properly. This is easy to test with Angular. Let's use Angular's double curly brace syntax to try to evaluate an expression inside our body tag:

```
{{ 2 + 2 }}
```

##Evaluating Expressions inside our HTML
Let's see how we can evaluate expressions inside double curly braces:

```html
<h1>{{ (50 * 2) / 4 }}</h1>
<h2>{{ "Shawn " + "Rodriguez" }}</h2>
```

##The ngController Directive
We're going to be talking a lot more about controllers over the next several days, so I'm going to gloss over a lot of the key points right now. The cool thing is that we can start making use of a controller right now without having to fully understand what they do.

To begin using an Angular controller, we first need to update our `ngApp` directive a little bit:

```html
<body ng-app="app">
```

Now, to actually add our controller to our HTML page, we need to use the `ngController` directive. Let's add a div with this directive to our HTML page:

```html
<div ng-controller="MainController as main"></div>
```

With this in place, we can now bind data from our controller into our view. Let's look at an example:

```javascript
//in our controller

self.test = "BOOM!";
```

```html
<!-- in our html -->

<div ng-controller="MainController as main">
  <h1>{{ main.test }}</h1>
</div>
```

##The ngClick Directive
The ngClick directive allows us to easily add an event listener to an HTML element that will run a function from our controller when the element is clicked.

Let's start by adding the directive to our HTML:

```html
<button ng-click="main.helloWorld()">Click Me!</button>
```

So far, our function doesn't do anything because we haven't defined a function called helloWorld() yet. Let's add this to our controller:

```javascript
self.helloWorld = helloWorld;

function helloWorld(){
  console.log("Hello World!");
}
```

Let's check our console to make sure that this function works.

There are Angular directives for lots of other DOM events (mouseenter, mouseleave, keypress, keydown, keyup, etc.). We will be making use of `ng-click` to help us illustrate several other directives we are going to learn today.

##The ngShow Directive
ngShow is used to conditionally display an HTML element. It does this by dynamically toggling the CSS display property to "none" on an element. Let's add an image to our page to see this in action:

```html
<img src="http://fillmurray.com/g/300/300">
```

Now let's add the ngShow directive to the image:

```html
<img ng-show="main.loveBillMurray" src="http://fillmurray.com/g/300/300">
```

This causes our HTML element to disappear. That's because ngShow the statement inside the directive currently evaluates to false. Let's see this a little bit more clearly:

```html
<img ng-show="{{ 2 + 2 == 4 }}" src="http://fillmurray.com/g/300/300">
```

Now our image appears because we have given the ngShow directive an expression that evaluates to true!

We can make the image disappear again by changing the expression to:

```html
<img ng-show="{{ 2 + 2 == 5 }}" src="http://fillmurray.com/g/300/300">
```

This illustrates the point, but is not that useful. Let's get to something more useful by incorporating ngClick. First, let's change the value of the ngShow directive back to what we had before:

```html
<img ng-show="main.loveBillMurray" src="http://fillmurray.com/g/300/300">
```

Now, let's add a button that will call a function:

```html
<button ng-click="main.love()">I LOVE BILL MURRAY!</button>
```

Currently, this button doesn't do anything because we haven't defined a function called `love()` yet. Let's add this to our controller:

```javascript
self.love = love;

function love(){
  self.loveBillMurray = true;
}
```

Now, if we click the button, Bill appears! How can we make him go bye-bye? Why don't we add another button that calls a different function:

```html
<button ng-click="main.hate()">I HATE BILL MURRAY!</button>
```

We'll need to add this function to our controller to get this button working:

```javascript
self.hate = hate;

function hate(){
  self.loveBillMurray = false;
}
```

##The ngHide Directive
The ngHide directive works just like ngShow, except in reverse.

##The ngRepeat Directive
This is a structural directive that dynamically creates DOM elements. It is used to iterate through an array to display things in the view. To see it in action, we will first need an array of elements. Let's add an array to our controller:

```javascript
self.favoriteBooks = ["The Sheltering Sky", "A Moveable Feast", "A Confederacy of Dunces", "Geek Love", "The Big Short"];
```

Now that we have an array in our controller, let's easily show all of these items in our view:

```html
<div>
    <h1>My Favorite Books</h1>
    <p ng-repeat="book in main.favoriteBooks">Title: {{ book }}</p>
</div>
```

Awesome! We just dynamically created five `<p>` elements in our view. If we had 100 elements in our array, it would have automatically created 100 `<p>` elements for us.

###Exercise
Could we use this with objects? Hellz yes we can!!! Take the next 10 minutes to convert our array of strings into an array of objects that have properties for title and author. Then, modify the HTML that uses the ngRepeat directive to output the book's title and author in the view.
