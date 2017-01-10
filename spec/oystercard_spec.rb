require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
    minb = Oystercard::MIN_BALANCE
    amount = 10
    fare = 5

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
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "changes to false when touched out" do
      subject.top_up(minb)
      subject.touch_in
      subject.touch_out(fare)
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it { should respond_to(:touch_in).with(0).argument }
    it "raises error if insufficient balance" do
      error = "Insufficient funds"
      expect{ subject.touch_in }.to raise_error(error)
    end
  end

  describe "#touch_out" do
    it { should respond_to(:touch_out).with(1).argument }
    it "deducts the correct fare after the journey" do
      subject.top_up(minb)
      subject.touch_in
      expect{subject.touch_out(fare)}.to change{subject.balance}.by -fare
    end
  end
end
