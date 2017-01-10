class Oystercard
attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def touch_out(fare)
    deduct(fare)
    @entry_station = nil
    "Your balance is £#{balance}"
  end

private

  def deduct(fare)
    @balance -= fare
  end
end
