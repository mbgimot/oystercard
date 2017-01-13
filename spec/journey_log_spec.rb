require "journey_log"
require "station"

describe JourneyLog do
  let(:oyster){ double(Oystercard.new(20)) }
  subject(:journeylog) { described_class.new(Journey, oyster) }

  let(:entry_station){ double(Station.new("euston", 1)) }
  let(:exit_station){ double(Station.new("victoria", 2)) }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
    allow(oyster).to receive(:deduct)
  end

  describe "#journey_log" do
    it "stores entry & exit stations as one journey" do
      journeylog.start_journey(entry_station)
      expect{journeylog.finish_journey(exit_station)}.to change{journeylog.journeys.length}.by 1
    end
  end

  describe "#in_journey?" do
    it "is initially not in a journey" do
      expect(journeylog.current_journey).to be_nil
    end
    it "changes to true when touched in" do
      journeylog.start_journey(entry_station)
      expect(journeylog.current_journey).to be_truthy
    end
    it "changes to false when touched out" do
      journeylog.start_journey(entry_station)
      journeylog.finish_journey(exit_station)
      expect(journeylog.current_journey).to be_nil
    end
  end
end
