#Array of Hope:  JS Arrays, Loops, and Iterating!

##Learning Objectives
By the end of today's lesson, you will be able to:

* create arrays
* use some of the more common array methods
* create while loops and for loops
* iterate through arrays

##Roadmap
1. We'll start by talking about what arrays are and when they're used.
2. We'll jump into the console and play around with arrays, utilizing some of the common methods available to arrays.
3. We'll do a mini-lab where we get into small groups and explore some more array methods.
4. We'll hit the white board and talk loops.
5. We'll play with loops in the console.
6. We'll tie it all together and use the things we learned about loops to iterate through our arrays.

##Arrays
###What is an array?

* A container for data, similar to a list.  You could think about it like a pill box.
* Each item in an array is called an element.
* Arrays can hold all kinds of different data types:  strings, integers, objects, functions, even other arrays!

###How do we create a new array?
There's two common ways to create a new array:

```javascript
var languages = ["JavaScript", "Ruby", "Swift", "Python", "Java"];
```

or

```javascript
var languages = new Array("JavaScript", "Ruby", "Swift", "Python", "Java");
```

###How do we access items inside an array?
Arrays are ordered, or "indexed", by number, beginning with 0.

We use the index number to access a specific item in an array.  Let's use our languages array as an example.  Let's say I want to access the first element in the array.  To do that, I would type `languages[0]`, which would return "JavaScript".  

Along those same lines, to access "Java", I would type `languages[4]`.

###What are some of the most common and useful methods available to arrays?

* Array.length (this is actually a property, not a method)
* Array.pop()
* Array.push()
* Array.reverse()
* Array.shift()
* Array.sort()
* Array.unshift()
* Array.splice()

Here's a great resource for JavaScript arrays:  https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array

Let's do a quick mini-lab! Break up into groups of 4.  Each group will have FIVE MINUTES to research one of these methods and then share with the class what that method does and how to use it.

##Loops
###What is a loop and what does it look like conceptually?
A loop is a tool in programming that can be used to repeatedly execute a piece of code.  It's one of the fundamental building blocks that you will use to write programs, along with conditionals and functions.

Today, we're going to look at two kinds of loops:

* condition-controlled loops (like a while loop)
* count-controlled loops (like a for loop)

###How does a while loop work?
Here's the syntax of a while loop:

```javascript
while (condition) {
	statement
}
```

Here's a sample while loop:

```javascript
var x = 0;

while (x < 3) {
    console.log(x);
    x++;
}
```
	
Here's another example:

```javascript
var sunny = true;

while (sunny) {
  console.log("It's sunny!");
  sunny = false;
}
```

###How does a for loop work?
For Loops have four basic parts:

* a counter variable
* a condition - this is an expression that is evaluated before each loop iteration.  If the condition is true, the statement is executed
* a final expression - this is evaluated at the end of each pass through the loop
* statement - this is the code that is executed as long as our condition evaluates to true

Here's the syntax of a for loop:

```javascript
for (counter-variable; condition; final-expression) {
  statement
}
```

Here's a sample for loop:

```javascript
for (var i = 0; i < 3; i++) {
  console.log(i);
}
```

###Avoiding Infinite Loops
Loops operate based on conditional statements, running as long as the condition it is checking against is true.  Take care not to write a condition that will always evaluate to true, otherwise you will create an infinite loop that will crash your browser (and maybe your whole computer).

##Iterating Over Arrays
###How can we use what we know about loops to iterate over an array?

####Mini Lab
Take five minutes to:
* create an array of your five favorite movies
* write a for loop that will cycle through every element in your array and log the name of each of your favorite movies, one by one, to the console.

**Here's an example using our languages array from above with a for loop:**

```javascript
for (var i = 0; i < languages.length; i++) {
  console.log(languages[i]);
}
```
