angular
    .module("todoApp")
    .controller("TodosController", TodosController);

    function TodosController(){
        var self = this;

        self.todoList = [
            {task: "build an awesome todo list", done: false},
            {task: "get super good at Angular", done: false},
            {task: "party on code", done: false},
            {task: "tackle the bonus challenges for this lesson", done: false},
            {task: "take a nap", done: false}
        ];

        self.text; //bound to input box for new todo
        self.addTodo = addTodo;
        self.deleteTodo = deleteTodo;

        function addTodo(){
            // var newTodo = {task: self.text, done: false};
            // self.todoList.push(newTodo);
            self.todoList.push({task: self.text, done: false});
            self.text = null;
        }

        function deleteTodo($index){
            self.todoList.splice($index, 1);
        }
    }
    









