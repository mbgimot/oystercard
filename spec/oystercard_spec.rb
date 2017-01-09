require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

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
      value = 10
      expect{ subject.top_up(value) }.to change{ subject.balance }.by value
    end
  end

  describe "#deduct" do
    it { should respond_to(:deduct).with(1).argument}
    it "deducts a fare from the card's balance" do
      subject.top_up(10)
      fare = 5
      expect{ subject.deduct(fare) }.to change{subject.balance }.by -fare
    end
    it "doesn't allow fare to be deducted if more than balance" do
      allow(oystercard).to receive(:balance).and_return(5)
      fare = 6
      error = "Insufficient funds"
      expect{ subject.deduct(fare) }.to raise_error(error)
    end
  end

  describe "in_journey?" do
    it "changes to true when touch_in" do
      station = Station.new
      station.touch_in(subject)
      expect(subject.in_journey).to be_truthy
    end
  end
end
