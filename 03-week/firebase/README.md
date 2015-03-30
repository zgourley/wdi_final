#All Your Firebase Are Belong To Us!

##Learning Objectives
* Understand what a database is and what its role is in our application
* Learn the basics of implementing an easy-to-use backend: Firebase
* Understand the difference between a synced array and a synced object in Firebase

##Roadmap
1. We'll look at an app that uses Firebase so that we know where we're headed and what Firebase is capable of.
2. We'll talk about databases generally and Firebase specifically.
3. You will spend five minutes looking at the code for today's lesson before Firebase has been added to understand the domain of our application and how it works _without_ Firebase.
4. We'll implement Firebase together during a code along.
5. You will practice implementing Firebase yourself using a provided starter application.

##What is a database?
A **database** is just **a place to store our data**. 

At this point, we've made several little apps that have some kind of data set, but thus far all our information has been stored locally – which means whenever we refresh the page, it's all reset back to whatever it was when we started.

In order to keep any changes, and have them persist, we have to hook up a database to store our information.

There are many types of databases, and we'll be using a few of them during WDI as we build backends that integrate with databases. For now, while we focus on rocking the front-end, we're going to use a pre-built solution, which we call a Database-as-a-Service, or a Backend-as-a-Service. In this case, we will use **Firebase**.

##Hello, [Firebase!](https://www.firebase.com/)

[Firebase](https://www.firebase.com/) is a pretty awesome pre-made backend. It's got a great free plan, for one, and it stores things in a way very much like what we're already used to with JavaScript objects. 

But it also integrates a handy "extra", which is that it stays in sync in realtime – when your data changes, it sends a message to your code, and our Angular application can keep our view up to date – which ends up seeming like a magical sync, and is very awesome.

We're going to look at how to sync **arrays**, and how to sync **objects**. Luckily, they're super similar, so it'll be fun.

If you don't already have an account, [go sign up for the free one](https://www.firebase.com/signup/). 

##Adding Firebase and AngularFire as Dependencies
In order to use Firebase with an Angular app, we need to add both the Firebase library and the AngularFire library as dependencies of our Angular app. AngularFire is the officially supported library for using Firebase with Angular.

Here's the configuration steps (click the links to go to the detailed instructions in this README):

1. Add script tags for Firebase and AngularFire to your HTML file. [Here's how.](#step-1-add-script-tags-for-firebase-and-angularfire)
2. Inject the Firebase module into our app module (this is our `app.js` file). [Here's how.](#step-2-inject-the-firebase-module-into-our-app-module)
3. Inject one or more of the AngularFire services--`$firebaseArray` and/or `$firebaseObject`--into our controller.[Here's how.](#step-3-inject-angularfire-services-into-our-controller)

With these three steps completed, our configuration is done and we can now set up our connection to Firebase!

####STEP 1: Add script tags for Firebase and AngularFire
Firebase has a bunch of official libraries, for lots of different programming languages. The ones we care about are for Javascript, and one that builds on their base Javacript library that specifically interacts with Angular.

To use them, include those libraries in the head of your HTML file. These are pulled directly from [Firebase's Quickstart Guide](https://www.firebase.com/docs/web/libraries/angular/quickstart.html#section-scripts), so this is straight from the horse's mouth.

```html
	<html>
    <head>
        <meta charset="utf-8">
        <title>America!</title>
        <link rel="stylesheet" href="css/main.css">
        <!-- Angular -->
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.js"></script>
        <!-- Firebase -->
        <script src="https://cdn.firebase.com/js/client/2.2.2/firebase.js"></script>
        <!-- AngularFire -->
        <script src="https://cdn.firebase.com/libs/angularfire/1.0.0/angularfire.min.js"></script>
	    <!-- our Angular Module -->
        <script src="js/app.js"></script>
        <!-- our Angular Controller -->
		<script src="js/presidentsController.js"></script>
    </head>
	...
```

####STEP 2: Inject the Firebase module into our app module
Now that we've sourced in the Firebase and AngularFire libraries, **we need to add `firebase` as a dependency in our app.** This step is registering the `firebase` module in our applicaiton so that we can use AngularFire in our controller in a few minutes.

```javascript
// in app.js, let's add `firebase` in our array of dependencies
angular
	.module('presidentsApp', ['firebase']);
```

The naming of `firebase` also comes from their documentation--we must use that name. They named the library, we just have to include it as whatever they named it. Now it's available to use throughout our app, like in our controller!

####STEP 3: Inject AngularFire service(s) into our controller 
In order for our controller to be able to use Firebase and AngularFire, we need to do some dependency injection, kinda like we did in our app module. For now, we will just inject AngularFire's `$firebaseArray` service into our controller. Without this step, our controller won't even know that Firebase exists.

That looks like this:

```javascript
	//presidentsController.js
	angular
		.module('presidentsApp')
		.controller('PresidentsController', PresidentsController);

		PresidentsController.$inject = ['$firebaseArray'];

		function PresidentsController($firebaseArray){
			...
		}
```

##Syncing our data with Firebase
###Hard-coded data 
So far, all the data we have worked with in Angular has lived right inside our controller--mostly as arrays, objects, or maybe plain, old strings. Now our data is going to live on Firebase and we will retrieve it every time our app loads.

If we're trying to keep our code clean, we can put our data--in this case, an array of objects--in a function, and make that function a property of our controller. It might look something like this:

```javascript
//js/presidentsController.js
angular
	.module('presidentsApp')
	.controller("PresidentsController", PresidentsController);

	PresidentsController.$inject = ['$firebaseArray'];

	function PresidentsController($firebaseArray){
		var self = this;

		//bind our function to the controller, 
		//and actually call it, so we can get the array stored in there
		self.presidentsList = getPresidentsList();

		//returns a list of hardcoded presidents
		function getPresidentsList(){
			var presidents = [
				{name: 'George Washington'},
			 	{name: 'John Adams'},
			 	{name: 'Thomas Jefferson'},
			 	{name: 'James Madison'},
			 	{name: 'James Monroe'},
			 	{name: 'John Quincy Adams'},
			 	{name: 'Andrew Jackson'},
			 	{name: 'Martin Van Buren'}
			];

			return presidents;
		}
	}
```

This isn't too different than what we've seen and been doing up to this point. But we need to make some changes so that this data saves to our Firebase database. But how?

###How to connect to Firebase
With Firebase, our goal is to keep the data structure simple. It's difficult to automatically sync things nested inside of things inside of other things, so we try to keep our data as organized & top-level as possible. 

You can think of a Firebase database as one big Javascript object. Each piece you want inside is a property, and has a URL of it's own to access it. It doesn't take much code or bandwidth to connect to each piece, so we connect to each piece individually.

If your database lives at `https://something.firebaseio.com`, you could have a piece of your database to store a list of presidents at:

```
https://something.firebaseio.com/presidents
```

You might want another piece to store a list of senators at: 

```
https://something.firebaseio.com/senators
```

Or maybe a piece to store information pertaining to our whole country at 

```
https://something.firebaseio.com/usa
```

One _awesome_ part is that you can just make these up depending on what data you need to store – and if that piece of your database doesn't already exist, when you save your data it'll get created automatically.

So let's see some code to connect to a piece of our database. It's only a few simple lines, thanks to the libraries we've included:

```javascript
//js/presidentsController.js

angular
	.module("presidentsApp")
	.controller("PresidentsController", PresidentsController);

	PresidentsController.$inject = ['$firebaseArray'];

	function PresidentsController($firebaseArray){
		var self = this;

		self.presidentsList = getPresidentsList();
		self.addPresident = addPresident;

		function getPresidentsList(){
			//use Firebase library's JS constructor to make a reference to our database
			var ref = new Firebase("https://presidents-demo.firebaseio.com/presidents");

			//use AngularFire library to download our data into a local object
			var presidents = $firebaseArray(ref);

			//return a synced Firebase array
			return presidents;
		}
	}
```

That's it. Now we've got an array that's synced to Firebase. If we change it anywhere, it updates everywhere. As we walk through using arrays & objects, try changing it both in your app, and with Firebase's GUI, to watch how closely connected they are.

##$firebaseArray()
Now, let's look at how to change data in our array in a way that will sync back to Firebase.

In our `getPresidents()` function, we return a variable called `presidents` that is a list of all the presidents that live in our Firebase database. It is important to understand that this is not a normal array; rather, it's a synced array. That means that we'll have to interact with it using custom methods that AngularFire gives us:

#####To add a new element to a Firebase array
```javascript
var newPrez = {name: "James Monroe"};
// instead of a normal push, we use $add
// self.presidentsList.push(newPrez);
self.presidentsList.$add(newPrez);
```

#####To delete an element from a Firebase array
```javascript
// instead of a normal splice, we use $remove, passing in the whole object that we want to delete
// self.presidentsList.splice(4, 1);
var oldPrez = self.presidentsList[4];
self.presidentsList.$remove(oldPrez);
```

#####To update an individual element in an array
```javascript
// to update an element, we change its attributes
// and call $save on the synced array, giving it the new attribute
self.presidentsList[1].name = "George X. Washington";
self.presidentsList.$save(self.presidentsList[1]);
```

##$firebaseObject()
Syncing arrays to Firebase is very useful, but you will likely find yourself wanting to sync objects with Firebase, too. Good news: you can do that!

A `$firebaseObject()` is actually very similar to a `$firebaseArray()` but instead of an array, it can be an object full of whatever properties you need.

Let's start by injecting AngularFire's `$firebaseObject` service into our controller:

```javascript
//js/presidentsController.js
angular
	.module("presidentsApp")
	.controller("PresidentsController", PresidentsController);

	PresidentsController.$inject = ['$firebaseArray', '$firebaseObject'];

	function PresidentsController($firebaseArray, $firebaseObject){
		...
	}
```

Now we can work with Firebase synced objects. Let's create one!

```javascript
//js/presidentsController.js

self.america = getAmericaObject();

function getAmericaObject(){
		//use Firebase's constructor to make a reference to our database
		var ref = new Firebase('https://presidents-demo.firebaseio.com/america');

		//use AngularFire library to download our data into a local object
		var america = $firebaseObject(ref);

		//return a synced Firebase object
		return america;
}
```

Awesome, now we've got a synced object! It doesn't have any properties inside it yet so let's add a few things to our `getAmericaObject()` function so that it will have a little bit of data in it right away:

```javascript
function getAmericaObject(){
		var ref = new Firebase('https://presidents-demo.firebaseio.com/america');
		var america = $firebaseObject(ref);

		america.name = 'United States of America';
		america.yearFounded = 1776;
		america.population = 317000000;
		america.states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California'];

		return america;
}
```

#####To add/update properties on an object
```javascript
self.government.name = "The United States of America";
self.government.foundingYear = 1776;
self.government.population = 317000000;
// now save it. notice you don't pass anything in here,
// but you're still calling $save() on the synced object
self.government.$save();
```

#####To update elements in an array inside an object
```javascript
self.america.states.push('Colorado');
self.america.$save();
```

Notice that working with arrays that are _inside_ a $firebaseObject is different than working with a $firebaseArray. If you are working with an array inside a $firebaseObject, you should use the regular array methods (push, pop, splice, etc.) to manipulate the array. 

When you are done, you must remember to call `$save` on the whole object that the array lives inside. If you forget this step, your new array data will not be synced back to Firebase and will be lost when you refresh the page.

#####To Remove Properties from an Object
```javascript
self.government.foundingYear = null;
self.government.$save();
```

##Promises and AngularFire's `$loaded()` method
Because Firebase is so fast and makes it so easy to work with "live" data, you don't necessarily realize that the data is being retrieved from Firebase asynchronously. That means that your data doesn't exist the moment your page loads. Rather, it has to be fetched from Firebase's server. 

While this process is usually pretty fast, it is **not** instantaneous. That means that we can't do anything to the data _until_ it arrives from Firebase. 

To make sure that we don't have any issues with this, we need to make use of AngularFire's `$loaded()` method. This method returns a promise which is resolved when the initial obejct data has been downloaded from Firebase. The promise resolves to the `$firebaseObject` itself.

Once the promise is resolved, we can invoke a callback function to act on our data however we like.

We can see how this works with the following code:

```javascript
function getAmericaObject(){
		var ref = new Firebase('https://presidents-demo.firebaseio.com/america');
		var america = $firebaseObject(ref);

		america.$loaded(function(){
			console.log('This loads second: ' + america.states);
		});

		console.log('This loads first: ' + america.states);
		return america;
	}

```

#####Want a little more info about promises?
Check out [this article](http://andyshora.com/promises-angularjs-explained-as-cartoon.html) to learn more!

##Easy As That! 
Alright, that's basics of using Firebase with Angular. This is a good start but make sure you [check out the Firebase documentation](https://www.firebase.com/docs/web/libraries/angular/) to learn more!