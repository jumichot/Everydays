class Object
  def self.const_missing(c)
    "Missing constant: #{c.inspect}!"
  end
end

describe "Constante missing is like method missing" do
  it "capture calls when constant name like a class name aren't defined" do
    expect(LOL).to eq "Missing constant: :LOL!"
  end
end
