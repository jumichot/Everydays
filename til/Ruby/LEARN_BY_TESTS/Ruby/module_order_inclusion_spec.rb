module C
  def hello
    p "world:C"
    super
  end
end

module B
  def hello
    p "world:B"
    super
  end
end

class A
  include B
  include C

  def hello
     "world:A"
  end
end

describe "Module inclusion" do
  it "test" do
    expect(A.new().hello).to eq "world:A"
  end
end
