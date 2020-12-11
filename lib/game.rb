class Game
  attr_reader :computer_board,
              :player_board,
              :computer_plays,
              :player_plays

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_plays = {
      cruiser: Ship.new("Cruiser", 3),
      submarine:Ship.new("Submarine", 2)
    }
    @player_plays = {
      cruiser: Ship.new("Cruiser", 3),
      submarine: Ship.new("Submarine", 2)
    }
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp
    if input == "p" or "P"
      computer_ship_placement
      player_ship_placement

    elsif input == "q" or "Q"
      puts "You have quit the game."
      exit
    else
      puts "Please try again."
      start
    end
  end

  def computer_ship_placement
    computer_cruiser_placement
    computer_submarine_placement
  end


  def computer_cruiser_placement
  #stuff
  end

  def computer_submarine_placement
    #stuff
  end

  def print_player_board
    puts @player_board.render(true)
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    print_player_board
    player_place_cruiser
    player_place_submarine
  end
