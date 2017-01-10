class Oystercard
attr_reader :balance

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient funds" if balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out(fare)
    @in_journey = false
    deduct(fare)
  end

private

  def deduct(fare)
    @balance -= fare
  end
end
