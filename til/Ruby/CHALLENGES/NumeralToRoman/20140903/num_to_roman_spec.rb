def convert(num)
  str = ""
  while num > 0
    [[10,"X"],[9,"IX"], [5,"V"],[4,"IV"],[1,"I"]].each do |i|
      if num >= i[0]
        str += i[1]
        num = num - i[0]
        break
      end
    end
  end
  str
end

describe "Numeral to Roman conversion" do
  it "convert 1 in I" do
    expect(convert(1)).to eq "I"
  end
  it "convert 2 in II" do
    expect(convert(2)).to eq "II"
  end
  it "convert 4 IV" do
    expect(convert(4)).to eq "IV"
  end
  it "convert 5 V" do
    expect(convert(5)).to eq "V"
  end
  it "convert 6 VI" do
    expect(convert(6)).to eq "VI"
  end
  it "convert 9 IX" do
    expect(convert(9)).to eq "IX"
  end
  it "convert 11 in XI" do
    expect(convert(11)).to eq "XI"
  end
  it "convert 19 in XIX" do
    expect(convert(19)).to eq "XIX"
  end
  it "convert 39 in XXXIX" do
    expect(convert(39)).to eq "XXXIX"
  end
end

def convert_cool(num)
  special_roman_values = {9 => "IX", 5 => "V", 4 => "IV", 5 => "V", 1 => "I"}
  special_roman_values.each do |numeral, roman|
    return roman + convert(num - numeral) if num >= numeral
  end
  ""
end
