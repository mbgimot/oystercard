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
    @journey = nil
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    multiple_touch_in
    start_journey(entry_station)
    total_balance
  end

  def touch_out(exit_station)
    multiple_touch_out
    finish_journey(exit_station)
    total_balance
  end

  def total_balance
    "Your balance is £#{balance}"
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def start_journey(entry_station)
    @journey = Journey.new
    @journey.start(entry_station)
  end

  def finish_journey(exit_station)
    @journey.finish(exit_station)
    save_current_journey
    @journey = nil
  end

  def multiple_touch_in
    save_current_journey if @journey
  end

  def save_current_journey
    @journey_log << @journey
    deduct(@journey.fare)
  end


  def multiple_touch_out
    if @journey.nil?
      @journey = Journey.new
    end
  end

end
