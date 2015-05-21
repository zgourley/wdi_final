# Inheritance

------

This challenge is about Object Inheritance.

Given the class definition (Ruby) and constructor function (JS) below find a way to add a method named “bark” without adding the method to the class/constructor itself.

Challenge should be completed in Ruby and JavaScript.

------



``` ruby
class Dog
  attr_reader :name, :breed, :sex, :age

  def initialize(name,breed,sex,age)
    @name = name
    @breed = breed
    @sex = sex
    @age = age
  end
end


p dog = Dog.new('fido','pit bull','male',9).bark #returns "woof!"

```

``` javascript
function Dog(name, breed, sex, age) {
  this.name = name;
  this.breed = breed;
  this.sex = sex;
  this.age = age;
}

dog = new Dog('fido','pit bull','male',9);
console.log(dog.bark()); //returns "woof!"
```

