class HaikuReview 
    attr_accessor :sentences

	def initialize input
		raise ArgumentError.new("This is not a string") unless input.is_a? String
		@sentences = input.split("/")
	end
    class << self
		def is_vowel letter
			raise ArgumentError.new("This is not a character") if letter.length != 1
			return ('aeiouy').include? letter.downcase
		end
	end




end

describe HaikuReview do

	it "can be initialize with a string of 3 sentences" do
      haiku_review = HaikuReview.new("Computer programs/The bugs try to eat my code/I must not let them.")
	  expect(haiku_review.sentences.count).to eq 3
	end

	it "should raise error when input is not a String" do
		expect { HaikuReview.new([]) }.to raise_error(ArgumentError)
	end

	it "should be recognized as a vowel" do
		expect(HaikuReview.is_vowel("a")).to eq true
	end

	it "should not be recognized as a vowel" do
		expect(HaikuReview.is_vowel("z")).to eq false
	end

	xit "sould find a group of syllabe" do

		expect(HaikuReview.new("").is_vowel("z")).to eq false
	end
end
