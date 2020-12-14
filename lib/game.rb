require './lib/ship'
require './lib/board'

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
      submarine: Ship.new("Submarine", 2)
    }
    @player_plays = {
      cruiser: Ship.new("Cruiser", 3),
      submarine: Ship.new("Submarine", 2)
    }
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp.downcase
    if input == "p"
      computer_ship_placement
      player_ship_placement
      loop do
        if @computer_plays[:cruiser].sunk? && @computer_plays[:submarine].sunk?
          p "You won!"
          break
        elsif @player_plays[:cruiser].sunk? && @player_plays[:submarine].sunk?
          p "I won!"
          break
        else
          display_board
          player_fired_upon(@player_board.cells.keys.sample(1).first)
          computer_fired_upon
        end
      end
    elsif input == "q"
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
    loop do
      randomized = @computer_board.cells.keys.shuffle![0..2]
      if @computer_board.valid_placement?(@computer_plays[:cruiser], randomized)
        @computer_board.place(@computer_plays[:cruiser], randomized)
        break
      end
    end
  end

  def computer_submarine_placement
    loop do
      randomized = @computer_board.cells.keys.shuffle![0..1]
      if @computer_board.valid_placement?(@computer_plays[:submarine], randomized)
        @computer_board.place(@computer_plays[:submarine], randomized)
        break
      end
    end
  end

  def print_player_board
    puts @player_board.render(true)
  end

  def print_computer_board
    puts @computer_board.render()
  end

  def player_ship_placement
    p"I have laid out my ships on the grid."
    p"You now need to lay out your two ships."
    p"The Cruiser is three units long and the Submarine is two units long."
    print_player_board
    player_cruiser_instructions
    player_cruiser_placement
    player_submarine_instructions
    player_submarine_placement
  end

  def player_cruiser_instructions
    p "Enter the squares for the Cruiser (3 spaces):"
    print "> "
  end

  def player_cruiser_placement
     player_input = gets.chomp.upcase.split(" ")
     if player_input.count == 3 && @player_board.valid_placement?(@player_plays[:cruiser], player_input)
       @player_board.place(@player_plays[:cruiser], player_input)

       print_player_board
     else
       p "Those are invalid coordinates. Please try again:"
       print "> "
       player_cruiser_placement
     end
  end

  def player_submarine_instructions
    p "Enter the squares for the Submarine (2 spaces):"
    print "> "
  end

  def player_submarine_placement
    player_input = gets.chomp.upcase.split(" ")
    if player_input.count == 2 && @player_board.valid_placement?(@player_plays[:submarine], player_input)
      @player_board.place(@player_plays[:submarine], player_input)


    else
      p "Those are invalid coordinates. Please try again:"
      print "> "
      player_submarine_placement
    end
  end

  def display_board
    p "COMPUTER BOARD".center(50, "=")
    print_computer_board
    p "PLAYER BOARD".center(50, "=")
    print_player_board
  end

  # computer firing on player board
  def player_fired_upon(coordinate)
    if !@player_board.cells[coordinate].fired_upon?
      @player_board.cells[coordinate].fire_upon
      if @player_board.cells[coordinate].render == "M"
        p "My shot on #{coordinate} was a miss."
      elsif @player_board.cells[coordinate].render == "H"
        p "My shot on #{coordinate} was a direct hit."
      elsif @player_board.cells[coordinate].render == "X"
        p "My shot on #{coordinate} sunk your ship."
      end
    else
      player_fired_upon(@player_board.cells.keys.sample(1).first)
    end
  end

  # player firing on computer board
  def computer_fired_upon
    puts "Enter the coordinate for your shot: "
    print "> "
    player_input = gets.chomp.upcase
    if @computer_board.valid_coordinate?(player_input)
      if @computer_board.cells[player_input].fired_upon?
        p "#{player_input} has already been fired upon. Please try again:"
        print "> "
        computer_fired_upon
      else
        @computer_board.cells[player_input].fire_upon
        if @computer_board.cells[player_input].render == "M"
          p "Your shot on #{player_input} was a miss."
        elsif @computer_board.cells[player_input].render == "H"
          p "Your shot on #{player_input} was a direct hit."
        elsif @computer_board.cells[player_input].render == "X"
          p "Your shot on #{player_input} sunk my ship."
        end
      end
    else
      p "Invalid coordinate. Please try again:"
      print "> "
      computer_fired_upon
    end
  end

end
