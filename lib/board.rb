require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include? coordinate
  end

  def valid_placement?(ship, coordinates_array)
    empty_placement?(coordinates_array) &&
    valid_ship_length?(ship, coordinates_array) &&
    consecutive_coordinates?(ship, coordinates_array)
  end

  def empty_placement?(coordinates_array)
    coordinates_array.any? do |coord|
      cells[coord].empty?
    end
  end

  def valid_ship_length?(ship, coordinates_array)
    ship.length == coordinates_array.length
  end

  def consecutive_coordinates?(ship, coordinates_array)
    possible_placements(ship).include? coordinates_array
  end

  def place(ship, coordinates_array)
    if valid_placement?(ship, coordinates_array)
      coordinates_array.each do |cell|
        @cells[cell].place_ship(ship)
      end
    end
  end

  def board_rows
    @cells.keys.each_slice(4).to_a
  end

  def board_columns
    columns = []
    board_rows.length.times do |index|
      columns << new_column(index)
    end
    columns
  end

  def new_column(index)
    board_rows.map do |row|
      row[index]
    end
  end

  def possible_placements(ship)
    rows_and_columns.flat_map do |coordinates_array|
      consecutive_placements(coordinates_array, ship)
    end
  end

  def rows_and_columns
    (board_rows + board_columns)
  end

  def consecutive_placements(coordinates_array, ship)
    coordinates_array.each_cons(ship.length).to_a
  end

  def render(show_ship=false)
    @board_line = "  1 2 3 4 \n"
    get_board_rows(show_ship)
    @board_line
  end

  def get_board_rows(show_ship)
    board_rows.each_with_index do |row, index|
      @board_line += row[index].split('').first
      get_row(row,show_ship)
      @board_line += " \n"
    end
  end

  def get_row(row,show_ship)
    row.each_with_index do |cell, index|
      @board_line += " #{@cells[cell].render(show_ship)}"
    end
  end
end
