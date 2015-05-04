#RSpec Lab: Model Specs!

##Learning Objectives
* Gain experience implementing a TDD workflow
* Practice using RSpec and Factory Girl to write model specs 

##Your Mission
You're building an online store that sells beer pong supplies (you know, cups, ping pong balls, tables...stuff like that). Today, you are going to be focused on building out the Product model for your online store. 

Because you're an amazing you are going to tackle the task using TDD. You should use RSpec and Factory Girl as your testing tools. 

**Remember: don't write the code until you've written the spec and seen it fail!**

##The Details
Here are some details about the attributes and behaviors of your Product model. You should have _at least_ one spec (aka "example") for each of the items listed below. Some of these will need more than one spec to really know that this works the way you expect it to. 

###Product attributes
* `name`
  - data type: string
  - required?: yes
* `sku`
  - data type: string
  - required?: yes
  - must be exactly 9 characters
* `wholesale_price`
  - data type: float
  - required?: yes
* `retail_price`
  - data type: float
  - required?: yes
* `description`
  - data type: text
  - required?: no
* `quantity`
  - data type: integer
  - required?: yes
  - this is the quantity that you have in stock

###Instance methods
>NOTE: Remember, instance methods are methods that you call on an _instance_ of a class (i.e. `@product.in_stock?`).

* `in_stock?`
  - should return a boolean value, based on a product's quantity
* `margin`
  - should return the difference between the wholesale price and retail price of a product
* `sell(qty)`
  - should take in an integer as an argument and decrement the product's quantity accordingly, but only if the product's quantity is greater than the incoming argument. If the sale is successful, the method should return the string "Thank you for your purchase". If a product's quantity is less than the incoming argument, then it should not decrement the product's quantity and should instead return the string "Cannot fulfill this order".

###Class methods
>NOTE: Remember, class methods are methods that you call on the _class itself_ (i.e. `Product.in_stock`).

* `in_stock`
  - should return an array of all instances of the Product class that are in stock
* `out_of_stock`
  - should return an array of all instances of the Product class that are out of stock 