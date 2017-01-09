class Oystercard
attr_reader :balance

  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(value)
    raise "£#{LIMIT} limit reached" if @balance + value >= LIMIT
    @balance += value
  end
end
