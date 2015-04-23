#INHERITANCE
--

Create three classes: Mammal, Human and Parakeet.

The Mammal class should contain a method named 'live_birth' that returns 'true' (boolean value, not string).

The Human class should inherit from Mammal and the Parakeet class should not. The output below should be expected:

```
eve = Human.new
tweety = Parakeet.new

p eve.live_birth    #returns true
p tweety.live_birth #returns undefined method `live_birth'

```

***NOTE!*** 
--
The Human class SHOULD NOT have it's own live_birth method, only the one that it inherits from Mammal.
