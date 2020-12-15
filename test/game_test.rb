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
    sample_coordinate = game.player_board.cells.keys.sample(1).first
    game.player_fired_upon(sample_coordinate)
    # if game.computer_board.cells.any? |cell|
    #     cell.fired_upon?
    #   end
    # end

    cells_fired_upon = game.computer_board.cells.find_all do |coordinate, cell|
      # require "pry"; binding.pry
      cell.fired_upon?
    end
    expected = ""
    # require "pry"; binding.pry
    cells_fired_upon.each do |cell|
      if cell.render == "M"
        expected = "My shot on #{cell} was a miss."
      elsif cell.render == "H"
        expected = "My shot on #{cell} was a direct hit."
      elsif cell.render == "X"
        expected = "My shot on #{cell} sunk your ship."
      end
    end

    assert_equal expected, game.player_fired_upon(sample_coordinate)
  end
end
