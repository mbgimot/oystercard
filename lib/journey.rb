require_relative 'station.rb'

class Journey
  attr_reader :trip

  def initialize
    @trip = Hash.new
  end

  def in_journey?
    !@trip[:entry_station].nil? && @trip[:exit_station].nil?
  end

  def start(entry_station = "Not touched in")
    @trip[:entry_station] = entry_station
  end

  def finish(exit_station = "Not touched out")
    @trip[:exit_station] = exit_station
  end
end
