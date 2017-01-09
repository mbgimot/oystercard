class Oystercard
attr_reader :balance

  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def deduct(fare)
    raise "Insufficient funds" if fare > balance
    @balance -= fare
  end
end
