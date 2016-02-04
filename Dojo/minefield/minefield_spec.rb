class Minefield
  attr_accessor :field

  def initialize(row,col)
    @row = row
    @col = col
    @field = Array.new(row*col,".")
  end

  def one_dimension_to_two_dimension(x,y)
    @field[y + x*@col]
  end

  def add_mine_at(n,m)
  end


  def to_s
    str = ""
    @field.each_with_index do |elem, index|
      str += elem
      str +=  "\n" if (index+1)%(@col)== 0
    end
    str
  end

end


describe Minefield do
  it "can display a 3x4" do
    minifield = Minefield.new(3,4)
    expect(minifield.to_s).to eq "....\n....\n....\n"
  end

  it "can dispaly a 1x1" do
    minifield = Minefield.new(1,1)
    expect(minifield.to_s).to eq ".\n"
  end

  it "can convert 1d to 2d" do
    minifield = Minefield.new(4,4)
    minifield.field[0] = 42
    minifield.field[3] = 3
    minifield.field[10] = 10
    expect(minifield.one_dimension_to_two_dimension(0,0)).to eq 42
    expect(minifield.one_dimension_to_two_dimension(0,3)).to eq 3
    expect(minifield.one_dimension_to_two_dimension(1,0)).to eq 4
    expect(minifield.one_dimension_to_two_dimension(2,2)).to eq 10
  end

  xit "can add a mine" do
    minifield = Minefield.new(4,4)
    minifield.add_mine_at(1,1)
    expect(minifield.to_s).to eq "....\n.X..\n....\n....\n"
  end
end
