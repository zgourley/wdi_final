#To Do...or...Not To Do!

##Learning Objectives
* Get hands on experience coding an Angular app from start to finish!
* Understand how an Angular controller interacts with the view to display _and_ manipulate our data!
* See more of Angular's awesome two-way data binding in action!

##Roadmap
* Today's lesson will be a code along.
* The finished code will be available in the class repo at the end of the day.

##Angular Directives We Will Use Today
```
ng-app
ng-controller
ng-model
ng-repeat
ng-class
ng-click
ng-submit
```

##Steps for Building our Angular Todo List
1. Let's test our controller to make sure it is hooked up properly. Add this variable to our controller: `self.test = "Testing our controller!";`. Then we will try to access this in our view and see if it works.

2. let's give our controller some data to work with:

	```javascript
	self.todoList = [
		{task: "build an awesome todo list", done: false},
		{task: "get super good at Angular", done: false},
		{task: "party on code", done: false},
		{task: "tackle the bonus challenges for this lesson", done: false},
		{task: "take a nap", done: false}
	];
	```

3. Before we render these tasks in our browser, let's add some structure to our html.  Let's create a header for our page.  Inside our wrapper div, let's add a `<header>` and a `<main>` tag.

	```html
		<header>
			<h1>YOU'VE GOT {{ ??? }} THINGS TO DO!</h1>
		</header>
		
		<main>
			<!-- we'll add the rest of the html for our app inside here -->
		</main>
	```

4. Now, we are going to use `ng-repeat` to display all of our todos on our page.  

	```html
		<section class="todo-list">
			<ul>
				<li ng-repeat="todo in todos.todoList">
					<input class="checkbox" type="checkbox" ng-model="todo.done">
					<span>{{ todo.task }}</span>
				</li>
			</ul>
		</section>
	```

5. Let's take a closer look at what's going on with that checkbox and how it's affecting our data. Checkboxes have a corresponding boolean value of either `true` or `false`, depending on the state of the checkbox.

6. Add `ng-class="{done: todo.done}"` to the span tag to dynamically apply styling when a task is marked as done.

7. Wouldn't it be great if we could add new items to our todo list?!  Let's give ourselves an input box and a button for that:

	```html
	<form class="add-todo">
		<input class="text-box" type="text" placeholder="I need to..." ng-model="todos.text">
		<input type="submit" class="btn btn-add" value="+">
	</form>
	```

8. That's pretty cool, but our submit button doesn't do anything yet.  We need to add a function to our controller!

	```javascript
		function addTodo(){
			self.todoList.push({task: self.text, done: false});
		}
		
		//this will add our new function as a property on our controller
		self.addTodo = addTodo;
	```

9. Sweet! Now, let's add `ng-submit="todos.addTodo()"` to our form element to call our function.

10. It sure would be nice if our text box would clear out after we add a todo.  We can do that!  We just need to add `self.text = null` to our addTodo() function.

11. Alright, now that we are able to add tasks and mark them as done, let's figure out how to actually delete tasks from our list.  We're going to need a function for that!  Let's add this to our controller:

	```javascript
		function deleteTodo($index){
			self.todoList.splice($index, 1);
		}
		
		//this will add our new function as a property on our controller
		self.deleteTodo = deleteTodo;	
	```

12. Now, we need to add a button for each task that has the `ng-click` directive attached.  Let's put the following snippet of code just below the `span` tag inside our ng-repeat:

	```html
		<button class="btn btn-delete" ng-click="todos.deleteTodo($index)">x</button>
	```

13. Let's add a counter that tells us how many tasks have been completed. Another function in our controller, please!

	```javascript
		function completedTodos(){
			var count = 0;
			for(var i = 0; i < self.todoList.length; i++){
				if(self.todoList[i].done){
					count++;
				}
			}
			return count;
		}
		
		//this will add our new function as a property on our controller
		self.completedTodos = completedTodos;
	```
		
14. Now, let's bind this data to our view.  We can add the following code inside the `<header>` tag of our html:

	```html
		<h4>{{ todos.completedTodos() }} things completed</h4>
	```

15. Cool--this todo app is getting pretty awesome!  The last thing we'll do is add a counter that tells us how many tasks have not been completed.  How can we do that?  You guessed it: another function in our controller!

	```javascript
		function remainingTodos(){
			var count = 0;
			for(var i = 0; i < self.todoList.length; i++){
				if(self.todoList[i].done === false){
					count++;
				}
			}
			return count;
		}
		
		//this will add our new function as a property on our controller
		self.remainingTodos = remainingTodos;
	```

16. Okay, let's bind this data to our view and then we're done!  Replace the `<h4>`tag inside your `<header>` tag with the following code:

	```html
		<h4>{{ todos.completedTodos() }} things completed | {{ todos.remainingTodos() }} things remaining</h4>
	```

##Bonus Stuff to Make _You_ Super Good at Angular!
* Display the date and time that each task was created
* Have your todo list display the newest tasks first
* Research the ngPluralize directive and figure out how to make the word "things" display as "thing" if the number that precedes it is 1.
* Add a feature that will archive all tasks that are marked as done and then remove them from the view (but not delete them from your todoList array).  Then, add a feature that will re-display the archived tasks.
* Our completedTodos() and remainingTodos() functions work, but there is a lot of repetition.  Refactor these functions into a single function that returns an object with properties called "completed" and "remaining".