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

  def clear
    @contents.clear
  end
end

stack = Stack.new
p stack.empty?
p stack.push(1)
p stack.push(2)
p stack.push(3)
p stack.peek
p stack.empty?
p stack.clear
