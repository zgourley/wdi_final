#Keep it Classy with Ruby Classes!

##Learning Objectives
* Understand the purpose of classes in Ruby
* Learn how to create our own Ruby class
* Write getter and setter methods
* use an options hash to instantiate new objects
* Use Ruby's `attr_accessor` and `attr_reader` methods
* make your own class!

##The purpose of classes
How could we create a bunch of similar objects--say, "people" objects--with what we know about Ruby so far?  Well, we could use hashes to store key-value pairs like `name`, `gender`, `age`, etc. 

But we would find out the limitations of this approach pretty quickly.  For example, we would have no way of directly adding behavior to these objects.  Unlike JavaScript, we can't just define a method inside a hash.  We also wouldn't be able to set basic default values for any of our objects.  If we were to take the approach of using hashes, we would have to create each one completely by hand every time we needed a new object. 

Luckily, Ruby has a better way: classes!  Classes are like blueprints or templates for creating similar kinds of objects.  They allow us to give our objects a consistent set of attributes and encapsulate behavior that is specific to a given type of object.

##Creating our own class
Let's start by making a new class called `Book`.  We will use this to create new book objects.

```ruby
class Book
end
```

That's all it takes to get started with a new class in Ruby!  Two things to be aware of:

  1. Class names in Ruby begin with an uppercase letter (unlike method names, which generally start with a lowercase letter).

  2. The name of our class is singular (`Book`, as opposed to `Books`). That is a clue as to how we should think about the role of classes in Ruby: it is the blueprint that will be responsible for creating new instances, it is not the instances themselves. Giving your classes singular names is a matter of convention and style--it is not something that the language enforces. It is a convention that Rails will stick to, so it is what we are going to do too.

Okay, so with our new class written, we can actually start using it to instantiate new objects:

```ruby
book1 = Book.new
```

We can take a look at our new `book1` object to verify that it is indeed an instance of our `Book` class:

```ruby
book1.instance_of?(Book)
# returns true
```

This is a good start, but so far, our class doesn't do much. It isn't yet able to create objects that hold the information we need them to hold.

##Writing an `initialize` method to create new objects
To fix this, we need to make use of a special Ruby method called `initialize`.  This method will let us set the "state" of our objects at the time that they are created.

```ruby
class Book
  def initialize(title, author, genre)
    @title = title
    @author = author
    @genre = genre
  end
end
```

Now, when we call `.new` on our `Book` class, the `initialize` method we wrote will automatically be invoked to assign values to new instances of our `Book` class. 

##Instance variables vs. local variables
Notice that we are storing the state of our book objects inside instance variables (those variables with the @ sign in front of them).  Each instance of our `Book` class will have their own unique set of these instance variables, which is what allows us to have different books with different authors, titles, etc.

Some things we should know about instance variables:

* Instance variables are bound to an instance of a class and they form what we call the state of an object. Every instance of a class has their own set of instance variables.

* Scope of instance variables:
  - instance variables are bound to the entire object (or, instance of the class). this means that they are available to every instance method defined in the class.
  - local variables, however, are scoped to the methods in which they are defined. this means that methods cannot access local variables that have been defined in other methods.

##Creating a new instance of our class
Alright, now that we've got that `initialize` method written, let's create a new book object!

```ruby
book1 = Book.new("Go Dog, Go", "Dr. Seuss", "childrens")
```

Now, if we look at the `book1` variable, we will see that we have an object that contains all the values we passed in to the `Book.new` method call. Boom!

So, we've got this awesome new book object. How can we access the individual attributes of the object?  Can we just call `book1.title`, for example, to see the value of that attribute? Not yet! If we do that, we actually end up with an undefined method error. 

We'll explore this in more depth in a minute, but first: it's time for an exercise!

##Accessing our object attributes: getter methods!
So we just saw that calling `book1.title` gave us a no method error. This illustrates an important point and and an important difference from JavaScript. In Ruby everything after the dot in ruby is a method call.

That means that when we say `book1.title` to access an attribute of our object, Ruby is looking inside our `Book` class for a method called `title`.

This kind of method has a particular name in Ruby (and many other programming languages). It's called a "getter" method. The job of a getter method is simply to return to us the value of an object's attribute.

Let's write one for `title`:

```ruby
def title
  @title
end
```

Now if we call `book1.title`, we will get the value of the `@title` instance variable returned to us.

There are two interesting things going on here that are worth discussing:

1. We can now see very clearly that the instance variables we assigned in our `initialize` method are accessible to other methods inside our class.
2. We also see Ruby's implicit returns in effect with our `title` method. Ruby methods always return the last thing they evaluate, even if you don't use the `return` keyword explicitly.

Let's write getter methods for the rest of our book attributes:

```ruby
def author
  @author
end

def genre
  @genre
end
```

Now we will be able to retrieve the values of all the attributes of our book objects--nice!

Let's go back to our `Tweet` class for our second exercise!

##Changing our attribute values: setter methods!
Alright, back to our `Book` class! What happens if we try to change the value of one of our book attributes?

```ruby
book1.genre = "non-fiction"
```

Oh snap! We get another undefined method error. In fact, we can see from the error message that Ruby tried to call a method named `genre=`.  That is very interesting!

What we need is a way to set new values on our object attributes: enter setter methods!

Writing setter methods is easy--you just need to make sure that your method name ends with an `=` sign. It should look like this:

```ruby
def genre=(value)
  @genre = value
end
```

Let's knock out the rest of the setter methods in our Ruby class:

```ruby
def title=(value)
  @title = value
end

def author=(value)
  @author = value
end
```

Alright, alright, alright! Getters and setters are now written for our `Book` class. You know what that means: go write the setter methods for our `Tweet` class!

##Using an options hash to give us more flexibility
Instead of passing arguments to a method one by one, we can pass in an options hash instead. This can give us a lot more flexibility when instantiating new instances of a class, especially if some of the attributes we want to set are optional or have default values that need to be applied.

For example, if we try to instantiate a new book object and only want to set the title property, we'll get an error:

```ruby
book2 = Book.new("The Sun Also Rises")

#ArgumentError: wrong number of arguments (1 for 3)
```

We can get around this by passing in `nil` for the other two arguments, but that kind of sucks.  An "options hash" is what we need!

Let's take a look at how that would work in our `Book` class:

```ruby
def initialize(options={})
  @title = options[:title]
  @author = options[:author]
  @genre = options[:genre]
end
```

Now, to create a new object, we could do it like this:

```ruby
book2 = Book.new({title: "The Sun Also Rises", author: "Ernest Hemingway", genre: "fiction"})
```

Ruby even gives us a shortcut when we're passing in a hash. We can omit the curly braces:

```ruby
book3 = Book.new(title: "Eloquent JavaScript", genre: "programming")
```

Notice that we didn't use curly braces AND we omitted one of the attributes (`author`) and it happily created a new instance for us!

Okay, time to refactor your `Tweet` class to take an options hash. Ready...go!

##Refactoring getters and setters with `attr_accessor` and `attr_reader`
* the differences between `attr_accessor`, `attr_reader`, and `attr_writer`
* example of why you would want to use attr_reader (`created_at` - don't want to overwrite this value)

##Exercises
* **First Exercise**
  - **You Do:**
    + create a class called `Tweet`
    + write a method called `initialize` that takes in four parameters: `message`, `tweeter` (this will be the name of the person who created the tweet), `location`, and `is_public?` (this will be a boolean).
    + inside the initialize method, set instance variables to the values of these incoming parameters.
  - **We Do:**
    + additionally, add a `created_at` attribute that is set to `Time.now`.
    + make `is_public` default to `true` unless specified otherwise
* **Second Exercise**
  - Write getter methods for all five attributes of our Tweet objects.
* **Third Exercise**
  - Write setter methods for four of the five attributes of our Tweet objects (don't write one for `created_at` - that should never get changed!).
* **Fourth Exercise**
  - refactor your `initialize` method to take in an options hash instead of four separate incoming parameters.
* **Fifth Exercise**
  - refactor your getter and setter methods to use `attr_accessor` or `attr_reader`
