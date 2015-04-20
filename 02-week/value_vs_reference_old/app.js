/* Primitive data types (String, Boolean, Number) are passed by value */

// Strings
var myString = "hello";
var myStringCopy = myString;
var myOtherString = "hello";

console.log(myString === myOtherString); // true
console.log(myString === myStringCopy); // true

// Numbers
var myNumber = 42;
var myNumberCopy = myNumber;
var myOtherNumber = 42;

console.log(myNumber === myOtherNumber); // true
console.log(myNumber === myNumberCopy); // true

// Boolean
var myBoolean = false;
var myBooleanCopy = myBoolean;
var myOtherBoolean = false;

console.log(myBoolean === myOtherBoolean); // true
console.log(myBoolean === myBooleanCopy); // true

/* Objects are passed by reference */

// Plain objects
var myObject = {key: 'val'};
var myObjectCopy = myObject;
var myOtherObject = {key: 'val'};

console.log(myObject === myObjectCopy); // true
console.log(myObject === myOtherObject); // false

// Arrays (are objects too)
var myArray = [3, 6, 9];
var myArrayCopy = myArray;
var myOtherArray = [3, 6, 9];

console.log(myArray === myArrayCopy); // true
console.log(myArray === myOtherArray); // false

// Functions (are objects too)
var myFunction = function (){return 0};
var myFunctionCopy = myFunction;
var myOtherFunction = function (){return 0};

console.log(myFunction === myFunctionCopy); // true
console.log(myFunction === myOtherFunction); // false

/* Let's look at them with functions */
// Passing by Value

function doStuffWithString(str){
  console.log(str);
  str = "My Own Thing Now"; // Change it
  console.log(str);
}

doStuffWithString(myString); // => "hello" => "My Own Thing Now"
console.log(myString); // "hello"

// Passing by Reference

function doStuffWithObject(obj){
  console.log(obj);
  obj.color = "red";
  console.log(obj);
}

console.log(myObject); // {key: 'val'}
doStuffWithObject(myObject); // => {key: 'val'} => {key: 'val', color: 'red'}
console.log(myObject); // {key: 'val', color: 'red'}
