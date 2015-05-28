function Stack() {

  var self = this;
  self.contents = []; //the array we'll be storing values in
  
  //add to top of stack
  //the optional if/else statement is used if we want
  //to limit the size of the stack
  self.push = function(num) {
    // if(self.contents.length ===1){
    //   return "Stack Overflow!";
    // }
    self.contents.push(num);
    return self.contents;
  };

  //remove top element of stack
  self.pop = function() {
    self.contents.pop();
    return self.contents;
  };

  //view the topmost element in stack
  self.peek = function() {
    return self.contents[self.contents.length - 1];
  };

  //if stack is empty returns true, else returns false
  self.isEmpty = function() {
    return self.contents.length === 0;
  };

  //delete all items in the stack
  self.clear = function(){
    self.contents.length = 0;
    return self.contents;
  };
}

var stack = new Stack();
console.log(stack.contents);
console.log(stack.isEmpty());
console.log(stack.push(2));
console.log(stack.push(2));
console.log(stack.isEmpty());
console.log(stack.contents);
console.log(stack.clear());
