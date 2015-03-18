#CSS Bonanza!
###Display Types, Normalize.css, Positioning, and Floats!

##Learning Objectives
* understand the difference between block, inline, and inline-block elements
* make use of Normalize.css to create consistent styling across browsers
* get more comfortable with positioning HTML elements using CSS

##Display Types
HTML elements are usually "block-level" elements or "inline" elements.

###Block-level Elements
From the [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Block-level_elements): 
>"A block-level element occupies the entire [width] of its parent element (container), thereby creating a 'block'...Browsers typically display the block-level element with a new line both before and after the element."

Examples of block-level elements:
* `<div>`
* `<footer>`
* `<form>`
* `<h1>, <h2>, <h3>, <h4>, <h5>, <h6>`
* `<header>`
* `<main>`
* `<nav>`
* `<ol>`
* `<p>`
* `<section>`
* `<table>`
* `<ul>`

###Inline Elements
Inline elements occupy only the space bounded by the tags that define the inline element.  Inline elements do not occupy an entire line of the page.  Instead, they flow from left to right across the page.

Examples of inline elements:
* `<strong>`
* `<span>`
* `<label>`

###Block-level vs. inline
There are a few important differences between block-level elements and inline elements:
* by default, block elements begin on new lines
* generally, block-level elements may contain inline elements and other block-level elements, while inline elements should not contain block-level elements
* block-level elements have width and height properties, while inline elements do not have width and height properties

###Inline-Block Elements
These are elements that have some of the behaviors and attributes of both block-level elements and inline elements.  They can have width and height properties like block-level elements, so rather than occupying an entire line, they flow from left to right across the page.

Examples of inline-block elements:
* `<img>`
* `<button>`
* `<input>`

##Normalize.css
All modern browsers add some default styling to HTML elements that can cause some unexpected/inconsistent appearance of webpages. Each browser's implementation of these defaults is a little bit different so we need a tool to help us override these browser-specific defaults with a consistent set of defaults that will render the same, regardless of the browser being used.

Enter **normalize.css**!  To use normalize.css, just download it from the [Normalize.css Github repo](https://github.com/necolas/normalize.css/) and add it as the first css file in the head of your html file.  That's it--boom!

##In-Class Styling Lab
###Setup
1. Let's make use of the HTML5 starter template that's in our class repo. We can copy it from the class repo to our working directory with the following command:

```
cp -R ~/wdi/class_repo/templates/html5-template ~/wdi/01-week/css_positioning
```

>NOTE: The command above might be a little bit different depending on the directory structure/names you set up on your machine.

2. Head over to http://html-ipsum.com.  First, copy the **Standard Navigation** List and paste it into the top of your index.html file. Next, grab **The Kitchen Sink** and paste that in.

###Styling
Let's start with a little bit of basic styling to kick things off:

```css
/*=============================
General Styles
=============================*/

body {
    margin: 10px;
}

/*here we are targeting the immediate children of body that are nav elements*/
body > nav {
    border: 1px solid #CCDCD0;
    background: #F3FAF5;
    margin: 10px;
}

/*this is targeting ul's that are descendants of nav and li's that are descendents of those ul's*/
body > nav ul li {
    display: inline-block;
}

body > nav ul li a {
    text-decoration: none;
}
```

###Margins
We'll start by playing around with the nav bar!

Remember `>` - it means 'direct descendant'. In the CSS above, for example, we are only targeting `nav` elements that are an immediate child of `body`.

**Why are we able to add margin to our `nav`?** Because our `nav` is a *block-level* element.

**How can we center our nav?** Could we use `margin <something> auto`?  Yes we can! But block-level elements naturally take up the full width of their parent container, so it's technically already centered. Let's give it a `max-width` of `500px` and add `margin: 10px auto;`.

```css
body > nav {
    border: 1px solid #CCDCD0;
    background: #F3FAF5;
    margin: 10px auto;
    max-width: 500px;
}
```

Boom--centered!

>Takeaway: Block-level elements are centered using `margin: <something> auto`, but only if the container has a width that is less than its parent.

###Text-Align
We've got our nav centered, but not the links inside the nav?  Why not? Inline and inline-block elements are like words in a sentence - they're not supposed to be sized, they're supposed to flow inline.

Because of this, we have to center inline and inline-block elements as if they were text. That's where `text-align` comes in.  We add it to the parent element of the inline or inline-block element we are trying to center.

```css
body > nav ul {
    text-align: center;
}
```

That looks pretty good, but it's not perfect. By default, `<ul>` elements have padding added on the left side of the element.

Let's fix that:

```css
body > nav ul {
    padding: 0;
    text-align: center;
}
```

Voila, perfectly centered links!

>Takeaway: Inline and inline-block level elements are centered using `text-align: center;` because they're supposed to flow as if part of a sentence.

###Positioning
So what's up with positioning?! Positioning is intended to move an element outside it's normal flow on the page, whether that flow is `inline`, `block`, or `inline-block`.

Let's try these different position values on our `nav` and `<a>` elements to see how they behave differently.

####Static
Everything by default is static. That's how it works already. If we don't specify a position, then it will behave as it naturally would.

####Relative
This is static with a twist - you can add `top`, `left`, `bottom`, `right` to relatively positioned elements, and adjust it based on where it's supposed to be naturally.

####Fixed
Fixed sticks to it's parent, which is the top-most parent, or the top-most parent *that's positioned relatively*. The cool part is that it doesn't move when you scroll. Try adding `position: fixed;` and some `top`, `left`, `bottom`, `right` to our nav and see what happens.

It takes it out of the flow of the document! It puts it wherever it's top-most parent lives and it stays put as you scroll.

####Absolute
Absolute is like fixed, but it doesn't stay glued to the screen when you scroll. In this way, it behaves like relative positioning, except absolutely positioned elements will always be positioned relative to the window, rather than to its parent container.

###Floating
WTF is floating? Floating originally started with the intention of having an image off to the side with text flowing around it - think of a magazine layout.

It takes an element out of the normal flow and moves it either left or right.

For a long time, there was no other way to get two things to sit next to each other, so everyone started using floats for *everything*. Now we have inline-block, which makes putting some things next to each other a lot easier - it's what inline-block was intended for.

Let's add an image to our html, just after the `<h1>` tag:

```html
<img src="http://fillmurray.com/g/200/200">
```

In our CSS, let's make a generic rule that grabs all the images on the page and floats them left:

```css
img {
  float: left;
  margin-right: 10px;
  max-width: 200px;
}
```

**What happened?** The block-level elements *before* the image stay as they are, and the block-level elements *after* it flow around the image.

**What if there's an inline-level element before it?** Let's try and see. Add a `<span>` with some text just before the image.  It flows around it, too!

###Floating Multiple Elements
**What happens when we have multiple images?** Let's add another image, right below the first one.

```html
<img src="http://fillmurray.com/g/300/300">
```

Floated elements start sitting next to each other. Interesting!
Now, finally - what happens when we switch sides? Change your floating from `left` to `right`.

```css
img {
  float: right;
  margin-right: 10px;
  max-width: 200px;
}
```

Notice that the order of the images change, depending on how you float them.

###WTF is Clearing?
Inevitably, you'll see a thousand things about clearing floats and how difficult it is. It's not that difficult if you understand what clearing is intended for.

Clearing lets you float multiple elements, but have them on top of each other instead of side-by-side.

```css
img {
  float: right;
  margin-right: 10px;
  max-width: 200px;
  clear: right;
}
```

####Clearfix, a.k.a. Fixing Floating
How do we *stop* elements from wrapping around flated stuff? Easy! There's a `clear: both;`, which stops floating on both the left and the right.

```css
h2 {
  clear: both;
}
```

We can see, though, that this doesn't look quite right. The `<h2>` is butting up right against the bottom of the images. For `clear: both` to work properly, we need to add an empty `<div>` just above the `<h2>`.  

Because adding an empty element to the page is kind of a lame hack, designers and developers have worked on millions of solutions to this problem, which is commonly called a 'clearfix'.  Here's a good one that will fix our problem:

```css
/*
* Clearfix: contain floats
*
* For modern browsers
* 1. The space content is one way to avoid an Opera bug when the
*    `contenteditable` attribute is included anywhere else in the document.
*    Otherwise it causes space to appear at the top and bottom of elements
*    that receive the `clearfix` class.
* 2. The use of `table` rather than `block` is only necessary if using
*    `:before` to contain the top-margins of child elements.
*/

.clearfix:before,
.clearfix:after {
  content: " "; /* 1 */
  display: table; /* 2 */
}

.clearfix:after {
  clear: both;
}
```

Now we can delete that stupid empty `<div>` and just apply the clearfix class to the element that precedes the element we are trying to clear. Boom!