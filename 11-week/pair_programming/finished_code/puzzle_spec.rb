require_relative 'answers.rb'

describe 'puzzle 1' do
  it 'should return the second to last word of a decoded base64 string' do
    expect(first_puzzle("UGFydHkgb24gY29kZSE=")).to eq('on')
    expect(first_puzzle("V0RJIGZvciBldmVyIQ==")).to eq('for')
  end
end

describe 'puzzle 2' do
  it 'should add a $ in front of each element of an array of numbers' do
    expect(second_puzzle([1, 5, 6.87, 234.32])).to eq(["$1", "$5", "$6.87", "$234.32"])
  end
end

describe 'puzzle 3' do
  it 'should zip two arrays of integers, if all elements are divisible by 5' do
    expect(third_puzzle([5, 10, 15, 20], [20, 15, 10, 5])).to eq([[5, 20], [10, 15], [15, 10], [20, 5]])
  end
  it 'should return a string' do
    expect(third_puzzle([1, 2, 3, 4, 5], [50, 30, 20, 25, 5])).to eq("All elements are not divisible by 5!")
  end
end

describe 'puzzle 4' do
  it 'should return the sum of the addition of the first 1000 prime numbers' do
    expect(fourth_puzzle(1000, '+')).to eq(3682913)
  end
  it 'should return the product of the multiplication of the first 23 prime numbers' do
    expect(fourth_puzzle(23, '*')).to eq(267064515689275851355624017992790)
  end
end

describe 'puzzle 5' do
  it "should return true if the number provided is a perfect square" do
    expect(fifth_puzzle(25)).to be(true)
  end
  it "should return false if the number provided is not a perfect square" do
    expect(fifth_puzzle(3)).to be(false)
  end
  it "should also be able to handle negative numbers" do
    expect(fifth_puzzle(-1)).to be(false)
  end
end

describe 'puzzle 6' do
  it 'should add 2 to a number' do
    expect(sixth_puzzle(5)).to eq(7)
  end
  it 'should handle exceptions gracefully' do
    expect(sixth_puzzle("here's a string")).to eq("Sorry, I can only accept numbers.")
  end
end