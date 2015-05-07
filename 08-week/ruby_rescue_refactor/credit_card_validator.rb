cc = ARGV[0]

if ARGV.empty?
  begin
    raise "No cc provided"
  rescue
    puts "Please enter a cc number"
    cc = gets.chomp
    if cc.empty?
      raise "Dude you need a cc to validate"
    end
  end
end

if cc.length < 13
  raise "Number is too short"
end

class CreditCard
  def initialize(num)
    @num = num
  end

  def type
    puts "lets check the type"
    if (begins_with("34") || begins_with("37")) && @num.length == 15
      return "AMEX"
    elsif begins_with("6011") && @num.length == 16
      return "DISCOVER"
    end
  end

  def valid?
    # return true if it passes the Luhn algorithm
  end

  private
  def begins_with(beg_str)
    beg_str_len = beg_str.length
    @num[0...beg_str_len] == beg_str
  end
end

credit_card = CreditCard.new(cc)

puts "the credit card is a #{credit_card.type} card"
