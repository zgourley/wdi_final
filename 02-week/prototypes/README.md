#JavaScript Prototypes & Inheritance

##Learning Objectives
* Understand how prototypes and inheritance work in JavaScript
* Learn how to add inheritable properties and methods to prototypes
* Learn how to make and use constructor functions that take advantage of effecient inheritance 

##Quick recap of JavaScript Objects
What are the basic characteristics of objects?
* Properties
* Methods

Almost everything in JavaScript is an object, the exceptions being `null` and `undefined`. That means that they can be assigned properties and methods.

##What is a prototype?
>####pro · to · type
>#####/ˈprōdəˌtīp/
>a first, typical or preliminary model of something, especially a machine, from which other forms are developed or copied.

* So far, we have only seen how to create objects using the object literal notation. If we wanted to create multiple similar objects that had the same methods, then we needed to explicitly add those methods to each object.
* A prototype is like a blueprint object for the object we are trying to create. It allows us to leverage something called "inheritance" to more effeciently create objects that have things in common with each other.

##What is "inheritance"?
* "Inheritance" is the passing down of the same properties and methods to similar objects and helps us avoid over-coding. Rather than taking up a ton of memory by storing the exact same data in multiple places, we can store it once and pass it down to other objects that need it.
* So far, the objects we have built using the object literal notation (`{}`) inherit directly from the highest level in the JavaScript hierarchy: the Object prototype. 
* All of the native JS data structures inherit all of their properties and methods from their very own prototypes.
* What would this heirarchy look like if we drew it out?

Let's look at an example using an array:

```javascript
var languages = ['JavaScript', 'Ruby', 'Python', 'C++', 'Swift'];
```

* All of the array methods that we learned last week (`pop()`, `push()`, `reverse()`, `splice()`, etc.) are actually built into the Array prototype (notice that I said Array with a capital 'A'). That means that every single array we create in JavaScript is inheriting all of those methods directly from it's prototype.

* Strings in JavaScript are also inheriting from a prototype:  the String prototype. All strings inherit properties and methods like `length`, `charAt()`, `toUpperCase()`, `toLowerCase()`, and others, from the String Prototype.

* Both the Array prototype and String prototype, as well as all the other prototypes that exist in JavaScript, inherit from the **Object prototype**. That means that changes to the Object prototype are propagated to all objects unless the properties and methods subject to those changes are overridden further along the prototype chain. This means we can do some pretty powerful--and pretty KrAZeeE--things in JavaScript.

##Adding new methods to the Object prototype
Let's start by creating a new person object using the object literal notation:

```javascript
var shawn = {
  name: 'Shawn',
  passion: 'partying on code'
};
```

Now, let's add a new method to the Object prototype that ALL objects will inherit:
    
```javascript
Object.prototype.sing = function(){
  console.log('Fa la la la la, la la la la!');
}
```

If we try to call the `sing()` method on our person object:

```javascript
shawn.sing() //we get 'Fa la la la la, la la la la!'
```

But it doesn't stop there. ALL objects that inherit from Object (that's Object with a capital 'O') now have this method:

```javascript
var languages = ['JavaScript', 'Ruby', 'Swift'];

languages.sing() //we get 'Fa la la la la, la la la la!'
```

##Closest Ancestor Wins!
Let's see what happens when we try to overwrite a method that exists lower down the prototype chain:

```javascript
Object.prototype.reverse = function(){
  console.log('We added a new reverse method!');
};

var someString = 'I am a string!';
someString.reverse(); // 'We added a new reverse method!'
languages.reverse(); // ['Swift', 'Ruby', 'JavaScript']
```

What we see happen here is that because the Array prototype already has a method called `reverse()`, it does not get overwritten by the method we added to the Object prototype. That's because JavaScript works its way up the prototypal chain looking for the first method it finds with that name.

##Adding Inheritable Properties to Prototypes
Because JavaScript is super awesome, we can extend existing prototypes and add new inheritable properties and methods to them. This is a very powerful tool to have in our toolbelts.

By default, arrays in JavaScript do not have a `shuffle()` method available. There are many times when shuffling an array can be a very useful feature. Let's see how we can add this functionality to the Array prototype so that all arrays can make use of it. We'll make use of the widely-used [Fisher-Yates shuffle algorithm](http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle):

```javascript
Array.prototype.shuffle = function(){
  var arr = this;

  for(var i = arr.length-1; i >=0; i--){
    var randomIndex   = Math.floor(Math.random()*(arr.length));
    var randomElement = arr[randomIndex];

    arr[randomIndex] = arr[i];
    arr[i] = randomElement;
  }
  return arr;
}
```

Now all arrays have a mutator method called `shuffle()` that randomly rearranges all of the elements:

```javascript
var nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

nums.shuffle() //returns something like [8, 3, 6, 7, 1, 5, 10, 2, 4, 9]
```

Boom!

##Inheritance and Constructor Functions
###Another way to build objects using Object.create()
Using inheritance, we can create new objects with our existing objects as prototypes:

```javascript
var myCar = {make: 'Porsche', model: 'Panamera', type: 'car'};
var yourCar = Object.create(myCar);

//the first argument of the Object.create method will be used as the prototype of the newly created object
console.log(myCar);
console.log(yourCar); //this object is identical to its prototype
```

We can add additional properties to the `yourCar` object:

```javascript
yourCar.interior = 'leather';
yourCar.sunroof = true;

console.log(yourCar); //has two new properties
console.log(myCar); //unchanged - does not have the additional properties
```

Let's look at the prototype chain of our car objects:

```javascript
Object.prototype.isPrototypeOf(myCar); //returns true
myCar.isPrototypeOf(yourCar); //returns true
yourCar.isPrototypeOf(myCar); //returns false
Object.prototype.isPrototypeOf(yourCar); //returns true
```

We can see that `Object.prototype.isPrototypeOf(yourCar)` returns `true`. That's because the `isPrototypeOf` method will look all the way up through the prototype chain to see if the object on the left is ever an ancestor of the object being passed in to the function.

###Other types of vehicles
What if, in addition to cars, we also have motorcycles and trucks? Should we still use the `Object.create` method to make new objects that inherit from myCar?

```javascript
var myCar = {make: 'Porsche', model: 'Panamera', type: 'car'};
var suzysTruck = Object.create(myCar);

console.log(suzysTruck); //{make: 'Porsche', model: 'Panamera', type: 'car'} 
```

As we can see from the console.log, this isn't quite right.  How can we deal with this? Constructor functions to the rescue!

###Constructor functions
First, let's determine all the common properties of a Vehicle class. What's a class, you ask? Think of it as a set of objects that all share and inherit from the same basic prototype.

| **All Vehicles** | **Some Vehicles** |
|------------------|-------------------|
| make             | numDoors          |
| model            | trunkSpace        |
| type             | bedLength         |
| turnOn()         | honk()            |

####Writing the Constructor Function
Okay, now that we've got a set of common properties that all vehicles will have, we can use these to build a constructor for our Vehicle class. Our constructor function will allow us to set up inheritance while giving us the flexibility to assign unique values to each of our objects.

```javascript
function Vehicle(make, model, type){
  this.make = make;
  this.model = model;
  this.type = type;
  this.turnOn = function(){
    return('Your ' + this.type + ' is on. Vroom, vroom!');
  };
}
```

Let's break this down a little bit:

1. There is a strong convention to use a capital letter for the name of the function. This make it clear to yourself and anyone else who looks at your code that this is a constructor function and is intended to be a template for creating new objects.

2. The purpose of a constructor function is to instantiate new objects that have a consistent set of properties. When this function is invoked to create a new object, the `this` keyword refers to the object that is being instantiated by the function. Therefore, when we say `this.name = name`, we are saying that the `name` property of the new object should have a value of the first argument that is passed in when the constructor function is called using the `new` keyword.

####Using the Constructor Function
Here's how we use our constructor to create a new object:

```javascript
var motorcycle = new Vehicle('Kawasaki', 'Ninja', 'motorcycle');
```

Notice that we use the **`new`** keyword to instantiate a new Vehicle object. If we console.log `motorcycle`, we can see we've got a new Vehicle object with all of the properties set up by our constructor function.

####Adding Properties to the Vehicle Prototype
This is a good start, but we aren't really making use of inheritance yet. We can see that the `turnOn()` function is actually being stored in every instance of the Vehicle constructor, even though it is EXACTLY the same code. We could make this more efficient by leveraging what we know about prototypes and inheritance.

Our constructor is just a function. It is not a prototype. Rather, it *has* a prototype. Let's set our constructor's prototype property so that every instance of our Vehicle constructor will refer to it for universal properties:

```javascript
function Vehicle(make, model, type){
  this.make = make;
  this.model = model;
  this.type = type;
} 

Vehicle.prototype = {
  turnOn: function(){
    return('Your ' + this.type + ' is on. Vroom, vroom!');
  }
};
```

You can see that we moved the `turnOn()` method out of the constructor function and into the Vehicle.prototype object. Now, new instances of our Vehicle constructor will refer to the Vehicle prototype to find the `turnOn()` method rather than having the method stored directly in every Vehicle instance.

Let's take a look at how this works:

```javascript
var motorcycle = new Vehicle('Kawasaki', 'Ninja', 'motorcycle');

console.log(motorcycle.make); //looks inside itself, finds a property called 'make' and logs 'Kawasaki'
console.log(motorcycle.turnOn()); //looks inside itself, doesn't find turnOn(), so it checks its prototype
```
