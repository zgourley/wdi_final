#INITIALIZE

--

Write a class named 'Fool' that has 3 attributes named "first", "second" and "third". Upon object creation:

* "first" should equal "Shame on you"
* "second" should equal "Shame on me"
* "third" should equal "Won't happen"

Each attribue should be able to be modified. See examples below.


```
p glenn = Fool.new 
#=> <Fool:0x007f9a33897590 @first="Shame on you", @second="Shame on me", @third="Won't happen">

p glenn.first
#=> "Shame on you

p glenn.third = "I fooled you!"
#"I fooled you!"

p glenn
#=> #<Fool:0x007fb8120c3290 @first="Shame on you", @second="Shame on me", @third="I fooled you">
```