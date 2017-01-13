require_relative "station"
require_relative "journey_log"

class Oystercard
attr_reader :balance, :journey_log

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journey_log = JourneyLog.new(Journey, self)
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    @journey_log.start_journey(entry_station)
    total_balance
  end

  def touch_out(exit_station)
    @journey_log.finish_journey(exit_station)
    total_balance
  end

  def total_balance
    "Your balance is £#{balance}"
  end

  def deduct(fare)
    @balance -= fare
  end
end
