require 'station'

describe Station do
  describe "#touch_in" do
    it { should respond_to(:touch_in).with(1).argument }
  end


  describe "#touch_out" do
    it { should respond_to(:touch_out).with(1).argument }
  end




end
