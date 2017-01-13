require "journey_log"
require "station"

describe JourneyLog do
  let(:oyster){ double("Oystercard") }
  subject(:journeylog) { described_class.new(Journey, oyster) }

  let(:entry_station){ instance_double("Station") }
  let(:exit_station){ instance_double("Station") }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
    allow(entry_station).to receive(:zone){1}
    allow(exit_station).to receive(:zone){1}
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
