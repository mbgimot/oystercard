require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe "default_balance" do
    it "has default balance of 0" do
      expect( subject.balance ).to eq 0
    end
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      value = 10
      expect( subject.top_up(value) ).to eq(value)
    end
  end

end
