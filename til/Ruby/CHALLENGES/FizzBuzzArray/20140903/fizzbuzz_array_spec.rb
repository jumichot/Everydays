def fizzBuzzCustom(first_label = "Fizz", second_label = "Buzz", first_value = 3, second_value = 5)
  (1..100).to_a.map { |num| (output = [[first_label][num % first_value],[second_label][num % second_value]].compact.join).empty? ? num : output }
end

describe "FizzBuzz Custom" do
  it "return 1 for 1" do
    expect(fizzBuzzCustom()[0]).to eq 1
  end
  it "return Fizz for 3" do
    expect(fizzBuzzCustom()[2]).to eq "Fizz"
  end
  it "return Buzz for 5" do
    expect(fizzBuzzCustom()[4]).to eq "Buzz"
  end
  it "return fizzbuzz for 44" do
    expect( fizzBuzzCustom()[44]).to eq "FizzBuzz"
  end
  it "can select label for special numbers" do
    expect(fizzBuzzCustom('Hey')[2]).to eq "Hey"
    expect(fizzBuzzCustom('Hey','There')[4]).to eq "There"
    expect(fizzBuzzCustom('Hey', 'There')[44]).to eq "HeyThere"
  end
  it "can select special numbers" do
    expect(fizzBuzzCustom("What's ", "up?", 3, 7)[80]).to eq "What's "
    expect(fizzBuzzCustom("What's ", "up?", 3, 7)[20]).to eq "What's up?"
  end
end
