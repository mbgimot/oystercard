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

  describe "#in_journey?" do
    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
    it "changes to true when touched in" do
      subject.start(entry_station)
      expect(subject).to be_in_journey
    end
    it "changes to false when touched out" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject).not_to be_in_journey
    end
  end

  describe "#journey_log" do
    it "has no journeys by default" do
      expect(subject.trip).to be_empty
    end
  end

  describe '#start' do
    it "has the entry station" do
      subject.start(entry_station)
      expect(subject.trip[:entry_station]).to eq(entry_station)
    end
    it "has the exit station" do
      subject.finish(exit_station)
      expect(subject.trip[:exit_station]).to eq(exit_station)
    end
    it "stores entry & exit stations as one journey" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.trip).to include(:entry_station, :exit_station)
    end
  end
end
