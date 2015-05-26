# including Ruby's Base64 module will come in handy, but it might not be the only module you need to add
require "base64"
require "prime"

def first_puzzle(string)
  Base64.decode64(string).split[-2]
end

def second_puzzle(array)
  array.map! { |num| num = "$#{num}" }
end

def third_puzzle(array1, array2)
  if array1.any? {|num| num % 5 != 0} || array2.any? {|num| num % 5 != 0}
    "All elements are not divisible by 5!"
  else
    array1.zip(array2)
  end
end

def fourth_puzzle(num, operator)
  primes = Prime.first(num)
  accum = (operator == '*') ? 1 : 0
  primes.reduce(accum, operator)

  #here's a longer, but maybe more clear, solution
  # if operator == "+"
  #   total = 0
  #   primes.each { |prime| total = total + prime }
  #   total
  # elsif operator == "*"
  #   total = 1
  #   primes.each { |prime| total = total * prime }
  #   total
  # end
end

def fifth_puzzle(num)
  num < 0 ? false : Math.sqrt(num) % 1 == 0
end

def sixth_puzzle(num)
  num.is_a?(Numeric) ? num += 2 : "Sorry, I can only accept numbers."
end