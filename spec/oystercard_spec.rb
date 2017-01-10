require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

  let(:entry_station) {double :victoria}
  let(:exit_station) {double :euston}


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

  describe "#in_journey?" do
    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
    it "changes to true when touched in" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it "changes to false when touched out" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(fare, exit_station)
      expect(subject).not_to be_in_journey
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
    expect(subject.entry_station).to eq entry_station
  end
  end

  describe "#touch_out" do
    it { should respond_to(:touch_out).with(2).argument }
    it "deducts the correct fare after the journey" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      expect{subject.touch_out(fare, exit_station)}.to change{subject.balance}.by -fare
    end
    it "forgets the entry station" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(fare, exit_station)
      expect(subject.entry_station).to be_nil
    end
  end

  describe "#journey_log" do
    it "has no journeys by default" do
      expect(subject.journeys).to be_empty
    end
    it "has the entry station" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(2, exit_station)
      expect(subject.journeys[0][:Entry_Station]).to eq(entry_station)
    end
    it "has the exit station" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(2, exit_station)
      expect(subject.journeys[0][:Exit_Station]).to eq(exit_station)
    end
    it "stores entry & exit stations as one journey" do
      subject.top_up(minb)
      subject.touch_in(entry_station)
      subject.touch_out(2, exit_station)
      expect(subject.journeys[0]).to include(:Entry_Station, :Exit_Station)
    end
  end
end
