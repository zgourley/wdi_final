angular
	.module("todoApp")
	.controller("TodosController", TodosController);

	function TodosController(){
		var self = this;
		
		self.todoList = [
			{task: "build an awesome todo app", done: false},
			{task: "get super good at Angular", done: false},
			{task: "party on code", done: false},
			{task: "tackle the bonus challenges for this lesson", done: false},
			{task: "take a nap", done: false}
		];

		self.text; //bound to input box for new todo
		self.addTodo = addTodo;
		self.deleteTodo = deleteTodo;
		self.completedTodos = completedTodos;
		self.remainingTodos = remainingTodos;

		//function that allows us to add new todos to our todoList
		function addTodo(){
			self.todoList.push({task: self.text, done: false});
			self.text = null;
		}

		//function that allows us to delete specific todos from our todoList
		function deleteTodo($index){
			self.todoList.splice($index, 1);
		}

		//returns a count of the tasks that have been marked as done
		function completedTodos(){
			var count = 0;
			for(var i = 0; i < self.todoList.length; i++){
				if(self.todoList[i].done){
					count++;
				}
			}
			return count;
		}

		//returns a count of the tasks that have not been marked as done
		function remainingTodos(){
			var count = 0;
			for(var i = 0; i < self.todoList.length; i++){
				if(self.todoList[i].done === false){
					count++;
				}
			}
			return count;
		}

	}
	