Why TDD?
---
1. It ensures the code works
2. It drives API design
3. We can change the implementation to optimize and rest assured that the API still works
4. We can swap components such as DBMS

Rspec
---
We'll be using the Rspec gem to do tdd in this class. Here is the
[documentation](http://rspec.info/documentation/3.2/rspec-expectations/#Equivalence)

To get use rspec in a project, make sure the rspec gem is installed.

You can bootstrap a project by running `rspec --init` in the terminal

To run an individual test you run `rspec myfile_spec.rb`

To run the tests in a folder you run `rspec myfoldername`

Let's TDD Checking Credit Cards
---
Before a credit card is submitted to a financial institution, it generally makes sense to run some simple reality checks on the number. The numbers are a good length and it's common to make minor transcription errors when the card is not scanned directly.

The first check people often do is to validate that the card matches a known pattern from one of the accepted card providers. Some of these patterns are:

| Card Type  | Begins With | Number Length |
|:-----------|:------------|--------------:|
| AMEX       | 34 or 37    | 15            |
| Discover   | 6011        | 16            |
| MasterCard | 51-55       | 16            |
| Visa       | 4           | 13 or 16      |

All of these card types also generate numbers such that they can be validated by the [Luhn](http://en.wikipedia.org/wiki/Luhn_algorithm) algorithm, so that's the second check systems usually try. The steps are:

1. Starting with the next to last digit and continuing with every other
   digit going back to the beginning of the card, double the digit
2. Sum all doubled and untouched digits in the number
3. If that total is a multiple of 10, the number is valid

For example, given the card number `4408 0412 3456 7893`

1.  `8 4 0 8 0 4 2 2 6 4 10 6 14 8 18 3`
2.  `8+4+0+8+0+4+2+2+6+4+1+0+6+1+4+8+1+8+3 = 70`
3.  `70 % 10 == 0`

Thus that card is valid.

Let's try one more, `4417 1234 5678 9112`

1.  `8 4 2 7 2 2 6 4 10 6 14 8 18 1 2 2`
2.  `8+4+2+7+2+2+6+4+1+0+6+1+4+8+1+8+1+2+2 = 69`
3.  `69 % 10 != 0`

That card is not valid.

Mission
---

Your mission is to write a program that accepts a credit card number. The program should print the card's type (or Unknown) as well a Valid/Invalid indication of whether or not the card passes the Luhn algorithm.

Use Rspec and a TDD aproach to write the program.


