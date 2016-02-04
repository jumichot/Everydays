def to_rom(num)
	{
		40 => "XL",
		10 => "X",
		9 => "IX",
		5 => "V",
		4 => "IV",
		1 => "I"
	}.each do |k,v| 
		return v + to_rom(num-k) if num >= k
	end 
	""
end

describe "Numeral to roman" do 
	it "test" do
		{
			1 => "I",
			2 => "II",
			3 => "III",
			4 => "IV",
			5 => "V",
			6 => "VI",
			7 => "VII",
			8 => "VIII",
			9 => "IX",
			10 => "X",
			11 => "XI",
			15 => "XV",
			19 => "XIX",
			20 => "XX",
			21 => "XXI",
			40 => "XL"
		}.each do |k,v|
			expect(to_rom(k)).to eq v
		end
	end
end