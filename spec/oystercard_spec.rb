require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

  let(:entry_station){ double(Station.new("euston", 1)) }
  let(:exit_station){ double(Station.new("victoria", 2)) }

  before do
    allow(entry_station).to receive(:name){"euston"}
    allow(exit_station).to receive(:name){"victoria"}
  end

  describe "balance" do
    db = Oystercard::DEFAULT_BALANCE
    limit = Oystercard::LIMIT
    it "has default balance of £#{db}" do
      expect( subject.balance ).to eq db
    end
    it "balance will not exceed £#{limit}" do
      error = "£#{limit} limit reached"
      allow(oystercard).to receive(:balance).and_return(0)
      expect { subject.top_up(limit) }.to raise_error(error)
    end
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      expect{ subject.top_up(amount) }.to change{ subject.balance }.by amount
    end
  end

  describe "#touch_in" do
    it { should respond_to(:touch_in).with(1).argument }

    it "raises error if insufficient balance" do
      error = "Insufficient funds"
      expect{ subject.touch_in(entry_station) }.to raise_error(error)
    end

    it "remembers which station the card touched in" do
      subject.top_up(amount)
      subject.touch_in(entry_station)
      expect(subject.journey.trip).to include(:entry_station)
      end
  end

  describe "#touch_out" do

    it { should respond_to(:touch_out).with(1).argument }

    it "deducts the correct fare after the journey" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by -1
    end

    it "forgets the entry station" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey.trip).to include(:exit_station)
    end
  end

  describe "#journey_log" do
    it "stores entry & exit stations as one journey" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_log[0].trip).to include(:entry_station, :exit_station)
    end
  end

end
