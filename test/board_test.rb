require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
      @board = Board.new
  end

  def test_if_board_exist
    assert_instance_of Board, @board
  end

  def test_it_has_correct_number_cells
    #Using key and values for asser_equal
    #It’s a hash, it should have 16 key/value pairs, which point to cell objects.
    @board.cells

    assert_equal 16, @board.cells.keys.count
    assert_equal 16, @board.cells.values.count
  end

  def test_it_has_valid_coordinate
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_valid_ship_placement_ship_lengths_not_same
    skip
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_if_coordinates_are_consecutive
    skip
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(submarine, ["C1", "B1"])
  end

def test_coordinates_cant_be_diagonal
  skip
   cruiser = Ship.new("Cruiser", 3)
   submarine = Ship.new("Submarine", 2)

   assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
   assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
 end
end
