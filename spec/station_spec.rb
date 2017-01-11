require 'station'

describe Station do

  subject(:station) { described_class.new("station", 1) }

  it "has a name" do
    expect(subject.name).to eq("station")
  end
  it "has a zone" do
    expect(subject.zone).to eq(1)
  end
end
