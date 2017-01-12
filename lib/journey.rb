require_relative 'station.rb'

class Journey
  attr_reader :trip

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @trip = Hash.new
  end

  def start(entry_station = nil)
    entry_station.nil? ? @trip[:entry_station] = entry_station : @trip[:entry_station] = entry_station.name
  end

  def finish(exit_station = nil)
    exit_station.nil? ? @trip[:exit_station] = exit_station : @trip[:exit_station] = exit_station.name
  end

  def in_journey?
    !@trip[:entry_station].nil? && @trip[:exit_station].nil?
  end

end
