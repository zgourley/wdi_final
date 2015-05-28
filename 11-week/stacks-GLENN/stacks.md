# Stacks

- Watch this video: https://www.youtube.com/watch?v=6QS_Cup1YoI




Imagine a stack of papers -- a paper placed on top will also be the first paper removed. This is known as **FIFO** (First-In, First-Out).

A **stack** is a primitive data structure that has the following fundamental methods:

- **push(item)** - Adds an item to the top of the stack.
- **pop** - Removes and returns the top-most item.
- **empty?** - Returns true if the stack is empty.


Stacks are used because:

- A stack is conceptually easier to reason about than an array.
- No matter how many elements are in the stack, an item can be pushed or popped in a constant time. (This is known as O(1) in computer science parlance.)


In the following implementation, we use Ruby's built-in Array class to implement a stack.

***RUBY IMPLEMENTATION W/ ARRAY***

``` ruby
class Stack

  #the array we'll be storing values in 
  def initialize
    @contents = []
  end

  #add to top of stack
  #the optional if statement is used if we want
  #to limit the size of the stack
  def push(elem)
    # return "Stack Overflow!" if @contents.length == 1
    @contents.push(elem)
  end

  #remove top element of stack
  def pop
    @contents.pop
  end

  #view the topmost element in stack
  def peek
    @contents.last
  end

  #if stack is empty returns true, else returns false
  def empty?
    @contents.length == 0
  end

  #delete all items in the stack
  def clear
    @contents.clear
  end
end
```



***JAVASCRIPT IMPLEMENTATION W/ ARRAY***

``` javascript
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
```



## Add a push method.

Add a new method to class Stack:

**push** — Adds an item to the stack

## Add a popmethod.

Add a new method to class Stack:

**pop** -- Removes the top-most item.

## Add a peek method.

Add a new method to class Stack:

**peek** -- Returns the top-most item (without removing it).

## Add a empty? method.

Add a new method to class Stack:

**isEmpty(JS) or empty?(Ruby)** -- Returns true if the stack is empty, false if it isn't.

## Add a clear method.

Add a new method to class Stack:

**clear** -- Removes all items from Stack.

