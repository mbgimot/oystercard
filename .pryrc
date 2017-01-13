require './lib/oystercard.rb'
require './lib/journey.rb'
require './lib/station.rb'

os = Oystercard.new

euston = Station.new("Euston", 1)
victoria = Station.new("Victoria", 2)
bank = Station.new("Bank", 3)

os.top_up(30)
