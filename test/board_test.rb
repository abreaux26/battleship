require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_if_board_has_16_cells
    #16 key/value pairs,  on assert_equal per each of them
    board = Board.new

    assert_equal 16, board.cells.keys.length
    assert_equal 16, board.cells.values.length
    board.cells.values.each do |cell|
      assert_instance_of Cell, cell
    end
  end

  def test_if_coordinate_is_valid
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_invalid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.valid_placement?(submarine, ["A1", "A2"])
  end

  def test_empty_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.empty_placement?(["A1", "A2", "A3"])
    assert_equal true, board.empty_placement?(["D1", "D2", "D3"])
  end

  def test_valid_ship_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_ship_length?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_ship_length?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_ship_length?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_ship_length?(submarine, ["A2", "A3"])
  end


  def test_consecutive_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.consecutive_coordinates?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.consecutive_coordinates?(submarine, ["A1", "C1"])
    assert_equal false, board.consecutive_coordinates?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.consecutive_coordinates?(submarine, ["C1", "B1"])
  end

  def test_ship_cant_be_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal true, cell_3.ship == cell_2.ship
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_board_rows
    board = Board.new

    expected = [
      ["A1", "A2", "A3", "A4"],
      ["B1", "B2", "B3", "B4"],
      ["C1", "C2", "C3", "C4"],
      ["D1", "D2", "D3", "D4"]
    ]

    assert_equal expected, board.board_rows
  end

  def test_board_columns
    board = Board.new

    expected = [
      ["A1", "B1", "C1", "D1"],
      ["A2", "B2", "C2", "D2"],
      ["A3", "B3", "C3", "D3"],
      ["A4", "B4", "C4", "D4"]
    ]

    assert_equal expected, board.board_columns
  end

  def test_new_column
    board = Board.new

    first_column = ["A1", "B1", "C1", "D1"]
    second_column = ["A2", "B2", "C2", "D2"]

    assert_equal first_column, board.new_column(0)
    assert_equal second_column, board.new_column(1)
  end

  def test_rows_and_columns
    board = Board.new

    rows = [
      ["A1", "A2", "A3", "A4"],
      ["B1", "B2", "B3", "B4"],
      ["C1", "C2", "C3", "C4"],
      ["D1", "D2", "D3", "D4"]
    ]

    columns = [
      ["A1", "B1", "C1", "D1"],
      ["A2", "B2", "C2", "D2"],
      ["A3", "B3", "C3", "D3"],
      ["A4", "B4", "C4", "D4"]
    ]

    assert_equal rows + columns, board.rows_and_columns
  end

  def test_consecutive_placements
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected = [
      ["A1", "A2", "A3"],
      ["A2", "A3", "A4"]
    ]

    assert_equal expected, board.consecutive_placements(["A1", "A2", "A3", "A4"], cruiser)
  end

  def test_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end

  def test_get_column_letter
    board = Board.new
    board.board_rows

    assert_equal "A", board.get_column_letter(["A1", "A2", "A3", "A4"], 0)
    assert_equal "D", board.get_column_letter(["D1", "D2", "D3", "D4"], 3)
  end
end
