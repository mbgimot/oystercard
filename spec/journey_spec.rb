require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

  let(:entry_station){ instance_double("Station") }
  let(:exit_station){ instance_double("Station") }
  let(:oyster){ instance_double("Oystercard") }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
  end

  describe "#initialize" do
    it "has no journeys by default" do
      expect(journey.entry_station).to be_nil
      expect(journey.exit_station).to be_nil
    end
  end

  describe '#start' do
    it "has the entry station" do
      journey.start(entry_station)
      expect(journey.entry_station).to eq(entry_station)
    end
  end

  describe "#exit" do
    it "has the exit station" do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq(exit_station)
    end
  end

  describe "#fare" do
    it "returns £#{Journey::MIN_FARE} if user did not cross any zones" do
      allow(entry_station).to receive(:zone){1}
      allow(exit_station).to receive(:zone){1}
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq(Journey::MIN_FARE)
    end

    it "returns £#{Journey::MIN_FARE + Journey::ZONE} if user crossed one zone" do
      allow(entry_station).to receive(:zone){1}
      allow(exit_station).to receive(:zone){2}
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq(Journey::MIN_FARE + Journey::ZONE)
    end

    it "returns £#{Journey::PENALTY_FARE} if user forgot to touch in" do
      journey.finish(exit_station)
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end
    it "returns £#{Journey::PENALTY_FARE} if user forgot to touch out" do
      journey.start(entry_station)
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end
  end
end
