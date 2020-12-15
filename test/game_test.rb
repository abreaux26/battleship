require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_game_has_boards
    game = Game.new

    assert_instance_of Board, game.computer_board
    assert_instance_of Board, game.player_board
  end

  def test_game_has_computer_ships
    game = Game.new

    computer_cruiser = game.computer_plays[:cruiser]
    computer_submarine = game.computer_plays[:submarine]

    assert_instance_of Ship, computer_cruiser
    assert_instance_of Ship, computer_submarine
  end

  def test_game_has_player_ships
    game = Game.new
    player_cruiser_placement = game.player_plays[:cruiser]
    player_submarine_placement = game.player_plays[:submarine]

    assert_instance_of Ship, player_cruiser_placement
    assert_instance_of Ship, player_submarine_placement
  end

  def test_computer_cruiser_placement
    game = Game.new

    assert_equal 3, game.computer_cruiser_placement.length
  end

  def test_computer_submarine_placement
    game = Game.new

    assert_equal 2, game.computer_submarine_placement.length
  end

  def test_if_player_fired
    game = Game.new
    game.computer_ship_placement

    actual = game.fire_upon_computer("A1")

    cells_fired_upon = game.computer_board.cells.find_all do |coordinate, cell|
      cell.fired_upon?
    end

    expected = ""

    cells_fired_upon.each do |coordinate, cell|
      if cell.render == "M"
        expected = "Your shot on #{coordinate} was a miss."
      elsif cell.render == "H"
        expected = "Your shot on #{coordinate} was a direct hit."
      elsif cell.render == "X"
        expected = "Your shot on #{coordinate} sunk your ship."
      end
    end

    assert_equal expected, actual
  end

  def test_if_computer_fired
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    game.player_board.place(cruiser, ["A1", "A2", "A3"])
    game.player_board.place(submarine, ["D1", "D2"])

    sample_coordinate = game.player_board.cells.keys.sample(1).first
    actual = game.player_fired_upon(sample_coordinate)

    cells_fired_upon = game.player_board.cells.find_all do |coordinate, cell|
      cell.fired_upon?
    end

    expected = ""

    cells_fired_upon.each do |coordinate, cell|
      if cell.render == "M"
        expected = "My shot on #{coordinate} was a miss."
      elsif cell.render == "H"
        expected = "My shot on #{coordinate} was a direct hit."
      elsif cell.render == "X"
        expected = "My shot on #{coordinate} sunk your ship."
      end
    end

    assert_equal expected, actual
  end

end
