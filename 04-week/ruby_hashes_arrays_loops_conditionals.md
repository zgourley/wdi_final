#RUBY BASICS PART 2 - Hashes, Arrays, Loops, Conditionals

---
##OBJECTIVES
* Be able to CRUD a Hash in Ruby
* Be able to CRUD an Array in Ruby
* Be able to iterate through Hashes and Arrays in Ruby
* Be able to work with while and until loops in Ruby
* Be able to work with conditionals in Ruby

---


###Hashes

Basic Hash Construction

```
* Using the hash rocket syntax

sample_hash   = {'one'=>1,'two'=>2}
sample_hash_2 = {:one=>1, :two=>2}

* Using colons to create a hash will create the keys as symbols

sample_hash_3 = {one:1,two:2}

```

Taking it to another level

```
* How to access a value (have to use bracket notation)

sample_hash_4 = {'one'=>1,'two'=>2,'three'=>3,'four'=>4,'five'=>5}
sample_hash_4["one"]  #=> Returns 1
sample_hash_4["five"] #=> Returns 5

* How to change the value of an element

sample_hash_4['one'] =  10


```

Methods to Know

* Creating and deleting elements from Hash

```
* Adding elements. Take note that keys can entered as strings or symbols and 
Ruby considers them to be different. Keep this in mind later when we work on 
creating/consuming APIs with Rails.

sample_hash_5 = {one:1,two:2}
sample_hash_5[:three]=3
sample_hash_5['three']=3

sample_hash_5 #=> returns
{:one=>1, :two=>2, :three=>3, "three"=>3}

sample_hash_5.delete("three")

```

* Size

```
sample_hash_6 = {one:1}
sample_hash_6.size #=> returns 1
sample_hash_6.length #=> also returns 1

sample_hash_6.empty? #=> returns false
{}.empty?            #=> returns true

```

* Other useful methods

```
sample_hash_7 = {'dog'=>'mammal','parakeet'=>'bird','tuna'=>'fish'}

sample_hash_7.keys #=> Returns an array with all keys
["dog", "parakeet", "tuna"]

sample_hash_7.values #=> Returns an array with all the values
["mammal", "bird", "fish"]
```

####EXERCISE!
```
Santa Claus is preparing his Xmas list...

Bobby(yoyo), Gretchen(kendama), Billy(Xbox), Maryam(Bicycle)

*Create a hash where the child's names are the keys and the toy they want is the value. Use the Hash methods you've learned to create an array with the children's names and another array with the children's presents.

**Bonus -- Imagine Santa wants to list the presents as the keys and the children's names as the values. There is a built-in method that will do this for us. Use Google to figure out how to do this.

```

---

###Arrays
Basic Array Construction

```
#Creating a new instance of the Array class

first_array = Array.new 
#=> []

#Using the literal constructor
	{}
second_array = [] 
#=> []

```

Taking it to another level

```
first_array = Array.new(3)
#=> [nil, nil, nil]

first_array = Array.new(3,'hello')
#=> ["hello", "hello", "hello"]

second_array = ['hello', 'hello', 'hello']
#=> ["hello", "hello", "hello"]

third_array = Array(1..5)
#=> [1, 2, 3, 4, 5]
```

Methods to Know

* Push, pop, shift, unshift, delete

```
sample_array = [1]
sample_array.push(2,3) #=>[1, 2, 3]
sample_array.pop #=> returns 3, array is now transformed

sample_array.unshift(0) #=> [0, 1, 2]

sample_array.shift #=> returns 0, but array is transformed

sample_array #=> [1,2]

sammple_array.delete(1) #=>[2]
sample_array.delete_at(0) #=>2

```
* First, last

```
sample_array = Array(1..5) #=> [1,2,3,4,5]
sample_array.first #=> 1
sample_array.last #=> 5
```

* Size

```
first_array = [1,2,3]
second_array = []

#The size and length arrays do the same thing
first_array.size #=> 3
second_array.length #=> 0

first_array.empty? #=> false
second_array.empty? #=> truen 

```

####EXERCISE

```
* Create an array with numbers from 1 to 100
* Create variables named first and last that are assigned the
  first and last values of the array you created
* Mutate the original array to remove the first and last items. 
  The new length should be 98 (verify this).
```
---

###Loops

* While loop

```
n = 1
while n < 11
  puts n
  n += 1
end
```

* Until loop

```
n = 1
until n > 10
  puts n
  n += 1
end
```

* Each iterator with code block and do block

```
sample_array = Array(1..5)
sample_array.each{|elem| puts elem}

sample_array.each do |elem|
  puts elem
  puts "The long way!!!"
end
```

* Map iterator with code block and do block

```
sample_array_2 = Array(1..5)
sample_array_2.map{|elem| elem ** 2}

sample_array_2.map do |elem|
  puts elem ** 2
  puts "The long way!!!"
end
```

* The difference between #map and #each is in what they return.
 #each returns the original array and map returns a transformed
 array. Also note that map & each are available for hashes

```
each_example = [2,3,4].each{|elem| elem ** 2}
map_example  = [2,3,4].map{|elem| elem ** 2}

p each_example
p map_example

each_example_2 = {two:2,three:3,four:4}.each{|key,value| elem ** 2}
map_example_2 = {two:2,three:3,four:4}.map{|key,value| elem ** 2}

p each_example_2
p map_example_2
```

####EXERCISE!!!
```
Create an array of integers. Using one of the loops you learned find the 
square root of each element in the array. ***HINT*** Finding square roots 
is similar to how you would find them in JavaScript. Use Google if you get 
stuck!
***BONUS*** Make sure the square roots are integers, not floats!
```
---

###Conditionals


* If/Elsif/Else

```
* Unless you're using a one-liner then you need to end your if statement with and 'end' statement.

x = 2

if x < 3
  puts 'less than 3'
end

* Writing the same thing as a one-liner

if x < 3 then puts 'less than 3' end
puts 'less than 3' if x < 3

* Using elsif

if x < 2
  puts "less than 2"
elsif x == 2
  puts "It's two!"
else
  puts 'greater than two!'
end
```

* Unless

```
* My own personal preference is to avoid the 'not' operator and state conditions in the positive. Using the 'unless' keyword is great for this.

x = true

puts "it's true!" if x != false

unless x == false
  puts "it's true!"
end

* Unless can also be used as a one-liner

puts "it's true!" unless x == false
unless x == true then puts "it's true!" end

*** You cannot use elsif with unless, only else ***

unless x == false
  puts "it's true!"
else
  puts "it's false!"
end

unless x == false
  puts "it's true!"
elsif
  puts "it's false!"
end

#returns an error
```

####EXERCISE!!!

```
* Create an array using one of the methods you've learned today
* Write an if/else conditional statement that will print different output based on the array length
* Rewrite the same if/else conditional using 'unless'.

***BONUS*** Rewrite both your if/else and unless statements using as many one-liners as possible.
```