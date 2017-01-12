require './lib/oystercard.rb'
require './lib/journey.rb'
require './lib/station.rb'

card = Oystercard.new

euston = Station.new("Euston", 1)
victoria = Station.new("Victoria", 2)
bank = Station.new("Bank", 1)

card.top_up(30)
