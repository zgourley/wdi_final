/* Value vs Reference */
console.log("we are in business");

// Primitive data types are passed by value
var myString = "hello";
var myStringCopy = myString;
var myOtherString = "hello";

console.log(myString === myStringCopy); // true
console.log(myString === myOtherString); // true

var myNumber = 42;
var myNumberCopy = myNumber;
var myOtherNumber = 42;

console.log(myNumber === myNumberCopy); // true
console.log(myNumber === myOtherNumber); // true

// Now let's pass it to a function
function doStuffWithString (str){
	console.log(str);
	str = "A Westside Story";
	console.log(str);
}

console.log(myString);
doStuffWithString(myString);
console.log(myString);


// Now Objects compare and pass by reference
var myObj = {myKey: 'myValue'};
var myObjCopy = myObj;
var myOtherObject = {myKey: 'myValue'};

console.log(myObj === myObjCopy); // true
console.log(myObj === myOtherObject); //false
console.log(myObjCopy === myOtherObject); // false

function doStuffWithObj (obj){
	console.log(obj);
	obj.austin = "the kim";
 	console.log(obj);
}

console.log(myObj); // {myKey: 'myValue'}
doStuffWithObj(myObj); // {myKey: 'myValue'} => {myKey: 'myValue', austin: 'the kim'}
console.log(myObj); // {myKey: 'myValue', austin: 'the kim'}
console.log(myObjCopy); //  {myKey: 'myValue', austin: 'the kim'}

function redefineTheObj (obj){
	console.log(obj);
	obj = {one: "you're like a dream"};
 	console.log(obj);
}

console.log(myObj); // {myKey: 'myValue', austin: 'the kim'}
redefineTheObj(myObj); // {myKey: 'myValue', austin: 'the kim'} => ????
console.log(myObj);






















