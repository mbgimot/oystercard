require_relative 'station.rb'

class Journey
  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def completed?
    @entry_station && @exit_station
  end

  def fare
    completed? ? MIN_FARE : PENALTY_FARE
  end

end
