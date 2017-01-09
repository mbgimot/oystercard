require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe "balance" do
    DEFAULT_BALANCE = 0
    LIMIT = 90
    it "has default balance of £#{DEFAULT_BALANCE}" do
      expect( subject.balance ).to eq DEFAULT_BALANCE
    end
    it "balance will not exceed £#{LIMIT}" do
      error = "£#{LIMIT} limit reached"
      allow(oystercard).to receive(:balance).and_return(DEFAULT_BALANCE)
      expect { subject.top_up(LIMIT) }.to raise_error(error)
    end
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      value = 10
      expect{ subject.top_up(value) }.to change{ subject.balance }.by value
    end
  end

end
