require "minitest/autorun"

class Demineur
  attr_accessor :board_width, :bomb_count

  def initialize args
    @board_width = args[:board_width]
    @bomb_count = args[:bomb_count]
    # @board = Array.new(@board_width,0)
  end

  def display_board
    "o o o o o o o o o o"
  end
  
end

class DemineurTest < MiniTest::Unit::TestCase
  def setup
   @demineur = Demineur.new(board_width: 10, bomb_count: 4)
  end

  def test_set_instance_variables_from_constructor
    assert_equal 10, @demineur.board_width
    assert_equal 4, @demineur.bomb_count
  end

  def test_that_it_has_a_board_with_no_bombs
    assert_equal "o o o o o o o o o o", @demineur.display_board
  end
end
