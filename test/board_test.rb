require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_if_board_has_16_cells
    #16 key/value pairs,  on assert_eqaul per each of them
    @board.cells

    assert_equal 16, @board.cells.keys.count
    assert_equal 16, @board.cells.values.count
  end

  def test_if_coordinate_is_valid
    board = Board.new
    board.cells

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement_based_on_length_coordinates
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.valid_placement?(submarine, ["A2", "A3"])
  end


  def test_if_coordinates_are_consecutive
    assert_equal false, @board.consecutive_coordinates?(["A1", "A2", "A4"])
    assert_equal false, @board.consecutive_coordinates?(["A1", "C1"])
    assert_equal false, @board.consecutive_coordinates?(["A3", "A2", "A1"])
    assert_equal false, @board.consecutive_coordinates?(["C1", "B1"])
  end

  def test_ship_cant_be_diagonal
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_if_placement_is_valid
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, @board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_placing_ship
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
    @cell_1.ship
    @cell_2.ship
    @cell_3.ship

    assert_equal true, cell_3.ship == cell_2.ship
  end
#
  def test_if_overlap_else_placement_invalid
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @board.place(cruiser, ["A1", "A2", "A3"])
    @cell_1.ship
    @cell_2.ship
    @cell_3.ship

    assert_equal false, @board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(submarine, ["", ""])
  end

#   def test_if_board_can_render
#   end

# end


end
