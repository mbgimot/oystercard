require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:entry_station){ instance_double("Station") }
  let(:exit_station){ instance_double("Station") }

  before do
    allow(entry_station).to receive(:zone){1}
    allow(exit_station).to receive(:zone){1}
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
      amount = 10
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
      minb = Oystercard::MIN_BALANCE
      oystercard.top_up(minb)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -Journey::MIN_FARE
    end
  end
end
