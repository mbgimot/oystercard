require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

  let(:entry_station){ double(Station.new("euston", 1)) }
  let(:exit_station){ double(Station.new("victoria", 2)) }
  let(:oyster){ double(Oystercard.new(20)) }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
  end

  describe "#initialize" do
    it "has no journeys by default" do
      expect(subject.entry_station).to be_nil
      expect(subject.exit_station).to be_nil
    end
  end

  describe '#start' do
    it "has the entry station" do
      subject.start(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe "#exit" do
    it "has the exit station" do
      subject.finish(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end

  describe "#fare" do
    it "returns #{Journey::MIN_FARE} if user completed a journey" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.fare).to eq(Journey::MIN_FARE)
    end
    it "returns #{Journey::PENALTY_FARE} if user forgot to touch in" do
      subject.finish(exit_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
    it "returns #{Journey::PENALTY_FARE} if user forgot to touch out" do
      subject.start(entry_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
  end
end
