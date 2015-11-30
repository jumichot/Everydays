describe "Fizzbuzz" do

  def fizzbuzz(num)
    (str = [["Fizz"][num%3],["Buzz"][num%5]].join.to_s).empty? ? num : str
  end

  def boom(num)
    (1..num).map { |i| (str = [["Fizz"][i%3],["Buzz"][i%5]].join.to_s).empty? ? i : str }.join(' ')
  end

  [1,2,7,8].each do |i|
    it "value for #{i} is #{i}" do
      expect(fizzbuzz(i)).to eq i 
    end
  end

  it "value for 3 is Fizz" do
    expect(fizzbuzz(3)).to eq "Fizz"
  end

  it "value for 5 is Buzz" do
    expect(fizzbuzz(5)).to eq "Buzz"
  end

  it "value for 6 is Fizz" do
    expect(fizzbuzz(6)).to eq "Fizz"
  end
  it "value for 10 is Buzz" do
    expect(fizzbuzz(10)).to eq "Buzz"
  end

  it "value for 15 is FizzBuzz" do
    expect(fizzbuzz(15)).to eq "FizzBuzz"
  end

  it "print the fizzbuzz" do
    expect(boom(20)).to eq "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz"
  end
end
