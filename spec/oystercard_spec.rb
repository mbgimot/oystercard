require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

  let(:entry_station){ double(Station.new("euston", 1)) }
  let(:exit_station){ double(Station.new("victoria", 2)) }
  let(:journey){ double(Journey.new) }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
    allow(journey).to receive(:entry_station){entry_station}
    allow(journey).to receive(:exit_station){exit_station}
  end

  describe "balance" do
    db = Oystercard::DEFAULT_BALANCE
    limit = Oystercard::LIMIT
    it "has default balance of £#{db}" do
      expect( oystercard.balance ).to eq db
    end
    it "balance will not exceed £#{limit}" do
      error = "£#{limit} limit reached"
      allow(oystercard).to receive(:balance).and_return(0)
      expect { oystercard.top_up(limit) }.to raise_error(error)
    end
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      expect{ oystercard.top_up(amount) }.to change{ oystercard.balance }.by amount
    end
  end

  describe "#touch_in" do
    it { should respond_to(:touch_in).with(1).argument }

    it "raises error if insufficient balance" do
      error = "Insufficient funds"
      expect{ oystercard.touch_in(entry_station) }.to raise_error(error)
    end
  end

  describe "#touch_out" do

    it { should respond_to(:touch_out).with(1).argument }

    it "deducts the correct fare after the journey" do
      oystercard.top_up(minb)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -Journey::MIN_FARE
    end

  describe "#journey_log" do
    it "stores entry & exit stations as one journey" do
      oystercard.top_up(minb)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.journey_log.length}.by 1
    end
  end


    describe "#in_journey?" do
      it "is initially not in a journey" do
        expect(oystercard.journey).to be_nil
      end
      it "changes to true when touched in" do
        oystercard.top_up(minb)
        oystercard.touch_in(entry_station)
        expect(oystercard.journey).to be_truthy
      end
      it "changes to false when touched out" do
        oystercard.top_up(minb)
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.journey).to be_nil
      end
    end
  end
end
