def fizzbuzz
  (1..100).to_a.map { |i| (str = [["Fizz"][i%3],["Buzz"][i%5]].join('')).empty? ? i : str }
end

describe "Fizzbuzz" do
  it "return 100 elements" do
    expect(fizzbuzz.count).to eq 100
  end
  it "return 2 for 2" do
    expect(fizzbuzz[1]).to eq 2
  end
  it "return fizz for 3" do
    expect(fizzbuzz[2]).to eq "Fizz"
  end
  it "return fizz for 5" do
    expect(fizzbuzz[4]).to eq "Buzz"
  end
  it "return fizzbuzz for 15" do
    expect(fizzbuzz[14]).to eq "FizzBuzz"
  end
end
