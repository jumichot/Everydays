class Fizzbuzz
  def self.to_s(max)
    (1..max).map { |i| (output = [["Fizz"][i%3], ["Buzz"][i%5]].compact.join).empty? ? i : output}.join(' ')
  end

end

describe "Fizzbuzz" do
  it "print a string" do
    expect(Fizzbuzz.to_s(15)).to eq "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz"
  end
end
