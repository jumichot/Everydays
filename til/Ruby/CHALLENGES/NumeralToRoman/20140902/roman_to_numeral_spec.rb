def convert(roman_num)
  special_values = {"X" => 10, "IX" => 9, "V" => 5, "IV" => 4, "I" => 1}
  special_values.each do |roman, numeral|
      return roman + convert(roman_num - numeral) if roman_num >= numeral
  end
  ""
end

describe "NumeralToRoman" do  
  it "convert 1 en I" do
    expect(convert(1)).to eq "I"
  end
  it "convert 2 en II" do
    expect(convert(2)).to eq "II"
  end
  it "convert 3 en III" do
    expect(convert(3)).to eq "III"
  end
  it "convert 4 en IV" do
    expect(convert(4)).to eq "IV"
  end
  it "convert 5 en V" do
    expect(convert(5)).to eq "V"
  end
  it "convert 6 en VII" do
    expect(convert(6)).to eq "VI"
  end
  it "convert 7 en VII" do
    expect(convert(7)).to eq "VII"
  end
  it "convert 9 en ix" do
    expect(convert(9)).to eq "IX"
  end
  it "convert 10 en x" do
    expect(convert(10)).to eq "X"
  end
  it "convert 11 en XI" do
    expect(convert(14)).to eq "XIV"
  end
end
