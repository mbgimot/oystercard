require_relative "station"
require_relative "journey"

class Oystercard
attr_reader :balance, :journey_log, :journey

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journey_log = []
    @counter = 0
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    multiple_touch_in
    starts_journey(entry_station)
    @counter += 1
    total_balance
  end

  def touch_out(fare, exit_station)
    multiple_touch_out
    deduct(fare)
    @journey.finish(exit_station)
    store_journey
    @counter = 0
    total_balance
  end

  def total_balance
    "Your balance is £#{balance}"
  end

private

  def store_journey
    @journey_log << @journey.trip
  end

  def deduct(fare)
    @balance -= fare
  end

  def multiple_touch_in
    if @counter >= 1
      @journey.finish
      store_journey
    end
  end

  def multiple_touch_out
    if @journey == nil
      @journey = Journey.new
      @journey.start
    end
  end

  def starts_journey(entry_station)
    @journey = Journey.new
    @journey.start(entry_station)
  end
end
