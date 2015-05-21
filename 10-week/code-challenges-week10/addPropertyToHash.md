# Add Property to Every Object in an Array

------

Given an array of hashes (objects in JS) write a function that will add a new key/value pair to each hash/object.

Challenge should be completed in Ruby and JavaScript.

------

***EXAMPLE:***

``` ruby
#ruby

arr = [{morning:true, time:"9am"}, {morning:false, time:"10pm"}]

add_property(arr,"sleepy",true) #returns [{:morning=>true, :time=>"9am", "sleepy"=>true}, {:morning=>false, :time=>"10pm", "sleepy"=>true}]

```

``` javascript
//javascript

arr = [{morning:true, time:"9am"}, {morning:false, time:"10pm"}];

addProperty(arr,"sleepy",true); //returns [ { morning: true, time: '9am', sleepy: true },{ morning: false, time: '10pm', sleepy: true } ]
```

