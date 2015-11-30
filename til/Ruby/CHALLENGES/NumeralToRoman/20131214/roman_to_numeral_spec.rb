class RomanToNumeral
  def convert num
    special_numbers = {10 => "X", 9 =>"IX", 5 => "V", 4 => "IV", 1 => "I"}
    special_numbers.each do |key, value|
      return value+convert(num-key) if num >= key
    end
    ""
  end
end

describe RomanToNumeral do
  it "#convert 0" do
    expect(subject.convert(0)).to eq ""
  end
  it "#convert 1" do
    expect(subject.convert(1)).to eq "I"
  end
  it "#convert 2" do
    expect(subject.convert(2)).to eq "II"
  end
  it "#convert 4" do
    expect(subject.convert(4)).to eq "IV"
  end
  it "#convert 5" do
    expect(subject.convert(5)).to eq "V"
  end
  it "#convert 6" do
    expect(subject.convert(6)).to eq "VI"
  end
  it "#convert 8" do
    expect(subject.convert(8)).to eq "VIII"
  end
  it "#convert 9" do
    expect(subject.convert(9)).to eq "IX"
  end
  it "#convert 10" do
    expect(subject.convert(10)).to eq "X"
  end
  it "#convert 31" do
    expect(subject.convert(31)).to eq "XXXI"
  end
end
