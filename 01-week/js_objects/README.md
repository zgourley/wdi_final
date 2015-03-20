#Object of My Affection: JS Objects!

##Learning Objectives
* Understand:
  - the purpose of objects
  - the notion of objects having attributes and behaviors
  - the structure/syntax of JS objects
* Make new objects using:
  - object literal notation
  - constructor functions
* Access and change object properties using dot notation

##What are objects and why are they useful?
JS objects might sound complicated, but they aren't! Like arrays, objects are containers that hold data. Unlike arrays, however, they aren't ordered by index. Instead, they are arranged into key-value pairs. We'll go into more detail about key-value pairs in a minute, but for now, here's the takeaway:  objects give us more more control over how we arrange and organize data than arrays.

##Attributes and Behaviors
Objects are a great way to represent real-world things. For now, let's think of objects as having two main categories of properties:

* attributes
* behaviors

Attributes can be thought of as the nouns of an object and behaviors can be thought of as the verbs.

Let's build out our mental model of objects by thinking about something we're all pretty familiar with: cars. What are some of the attributes and behaviors of a car?

| **Attributes** | **Behaviors** |
| -------------- | ------------- |
| make           | accelerate    |
| model          | deccelerate   |
| color          | honk          |

##Making New Objects
###Object Literal Notation
Alright, let's take this concept of a car and turn it into an actual JavaScript object.  We'll start by just adding the attributes of our car and tackle the behaviors in a few minutes.

Here's how we can write a basic object:

```javascript
var myCar = {
  make: "Porsche",
  model: "Panamera",
  color: "black"
};
```

Now, how can we access the properties of an object?  In JavaScript, we can use dot notation!

```javascript
myCar.make //returns "Porsche"
myCar.model //returns "Panamera"
myCar.color //returns "black"
```

Changing the value of any of our object's properties is simple: just reassign it!

```javascript
myCar.color = "red";

//now myCar.color will return "red"
```

What's that you say? You want to add a property to our object? No problem. We can just define new properties (or "key/value pairs") using the same dot notation:

```javascript
myCar.msrp = 114000;
```

Alright, maybe I don't want to have that `msrp` property on the `myCar` object any longer. Let's remove it from the object:

```javascript
delete myCar.msrp
```

Let's take a look at those "behaviors" we talked about earlier. When we talk about behaviors, we are going to be writing functions inside our objects that do something. Let's take "honk", for example:

```javascript
myCar.honk = function(){
  console.log("BEEP, BEEP!");
};

//if we added this property when we created the object, it would look like this:
var myCar = {
  make: "Porsche",
  model: "Panamera",
  color: "black",
  honk: function(){
    console.log("BEEP, BEEP!");
  }
};
```

###A More Complex Example
Let's take a look at a more complex, real-world example of how we might use JavaScript objects in a web app.  We'll create some user objects:

```javascript
var shawn = {
  name: "Shawn",
  email: "shawn@example.com",
  birthday: new Date("January 1, 1995"),
  favFoods: ["enchiladas", "barbeque", "fried chicken"],
  family: {
    spouse: "Meredith",
    mom: "Rebecca",
    dad: "Bill",
    siblings: ["Kevin"]
  }
}
```

Cool, let's play around with this object in the console a little bit. We can explore how the value of our `favFoods` property is actually an array. We could access individual elements in the array or we could even iterate through the favorite foods using a for loop.

We also see that the value of the `family` property in the `shawn` object is actually another object.  How could we access the key-value pairs inside this object?

Now, let's take this to the next level:

```javascript
var meredith = {
  name: "Meredith",
  email: "meredith@example.com",
  favFoods: ["ice cream", "fajitas"],
  family: {
    spouse: shawn //here we set another object as the value of this property
  }
}
```

Let's change the value of Shawn's spouse to be the object held in the variable name `meredith`:

```javascript
shawn.family.spouse = meredith;
```

Now, we can go "around the world" and do something kind of mind-bending:

```javascript
shawn.family.spouse.family.spouse.name

//this will return "Shawn"
```

That is of course not very useful or practical, but it does illustrate how we access the properties of objects.

Let's do something a little bit more practical. Let's add a method to the `shawn` object that calculates his age. 

Because this is JavaScript, we can add new properties to an object at any time.  Let's add a property called `age` that will hold a function to calculate his age:

```javascript
var shawn = {
  name: "Shawn",
  email: "shawn@example.com",
  birthday: new Date("January 1, 1995"),
  favFoods: ["enchiladas", "barbeque", "fried chicken"],
  family: {
    spouse: meredith,
    mom: "Rebecca",
    dad: "Bill",
    siblings: ["Kevin"]
  },
  age: function(){
    var numMilleseconds = new Date() - this.birthday;
    return("Shawn is " + numMilleseconds + " milleseconds old!");
  }
}
```

Having methods like this on an object can be very useful for calculating dynamic values on the fly!

##Constructor Functions
So far, we have been creating objects completely from scratch using the object literal notation. Sometimes it's helpful to have a template of sorts for creating new objects. For example, you might want to create a bunch of unique objects from the same template, like the user objects we were creating above.

JavaScript has a special function called a "constructor function" that can help us do that.  Let's look at how to write a simple constructor function:

```javascript
function Person(name, email, birthday){
  this.name = name;
  this.email = email;
  this.birthday = birthday;
}
```

Here's how we can use our constructor function to create a new object:

```
var blaise = new Person("Blaise", "blaise@example.com", "March 1, 1995");
```

Let's break this down a little bit:

1. There is a **strong** convention to use a capital letter for the name of the function.  This make it clear to yourself and anyone else who looks at your code that this is a constructor function and is intended to be a template for creating new objects.

2. The purpose of a constructor function is to instantiate new objects that have a consistent structure of key-value pairs. When this function is invoked to create a new object, the `this` keyword refers to the object that is calling the function.  Therefore, when we say `this.name = name`, we are saying that the `name` property of the new object should have a value of the first argument that is passed in when the function is called.

##Bonus Lab
###Create The Ninja Turtles as JS Objects
1. Create four objects, one for each Ninja Turtle, with the following attributes:
  * name
  * color
  * weapon
  * namedAfter
  * likesPizza (the value of this property should be a boolean)

  **Extra credit if you use a constructor function to create the turtles!**

2. Create a new array called `turtles` and add each of your Ninja Turtle objects to this array.  Use a for loop to iterate through your array and console.log the name of each turtle.
3. Make Leonardo eat pizza:
  * add a boolean property to Leonardo called `pizzaEaten` (initially set to false)
  * add a method (remember, a method is just a function that exists as a property of an object) to Leonardo called `eatPizza()` which does the following:
    - If `pizzaEaten` is true, console.log "Leonardo has already eaten!" and set `pizzaEaten` to false.
    - if `pizzaEaten` is false, console.log "Leonardo is eating pizza!" and set `pizzaEaten` to true.

**For Your Reference:**
* Leonardo - blue, ninjato, Leonardo da Vinci, true
* Michelangelo - orange, nunchucks, Michelangelo Buonarroti, true
* Raphael - red, sai, Raffaello Sanzio da Urbino, true
* Donatello - purple, bo, Donato di Niccolo di Betto Bardi, true
