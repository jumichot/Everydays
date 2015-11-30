module FizzBuzz
  class Finder

    def to_a limit
      (1..limit).map {|num| find(num) } 
    end

    def find num
      special_num = {15 => "FizzBuzz", 5 => "Buzz", 3 => "Fizz" }
      special_num.keys.each do |n|
        return special_num[n] if (num)%n == 0
      end
      num
    end
  end
end

module FizzBuzz
  describe Finder do
    describe "#find" do
      it "find 1" do
        expect(subject.find(1)).to eq 1
      end
      it "find 2" do
        expect(subject.find(2)).to eq 2
      end
      it "find Fizz for 3" do
        expect(subject.find(3)).to eq "Fizz"
      end
      it "find 4" do
        expect(subject.find(4)).to eq 4
      end
    end

    describe "#to_a" do
      it "reports correctly the first 15 lines" do
        expect(subject.to_a(15)).to eq [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz",13,14,"FizzBuzz"]
      end
    end
  end
end
