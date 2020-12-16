require './lib/ship'
require './lib/board'

class Game
  attr_reader :computer_board,
              :player_board,
              :computer_ships,
              :player_ships

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_ships = {
                        cruiser: Ship.new("Cruiser", 3),
                        submarine: Ship.new("Submarine", 2)
                      }
    @player_ships = {
                      cruiser: Ship.new("Cruiser", 3),
                      submarine: Ship.new("Submarine", 2)
                    }
  end
  def greeting
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp.downcase
    start(input)
  end

  def start(input)
    if input == "p"
      play_game
    elsif input == "q"
      puts "You have quit the game."
    else
      puts "Please try again."
      start(gets.chomp.downcase)
    end
  end

  def place_all_ships
    computer_ship_placement
    player_ship_placement
  end

  def continue_firing
    display_board
    player_fired_upon(@player_board.cells.keys.sample(1).first)
    computer_fired_upon
  end

  def play_game
    place_all_ships
    loop do
      if @computer_ships[:cruiser].sunk? && @computer_ships[:submarine].sunk?
        p "You won!"
        break
      elsif @player_ships[:cruiser].sunk? && @player_ships[:submarine].sunk?
        p "I won!"
        break
      else
        continue_firing
      end
    end
  end

  def computer_ship_placement
    computer_cruiser_placement
    computer_submarine_placement
  end

  def computer_cruiser_placement
    loop do
      randomized = random_computer_board_coordinate(0..2)
      if @computer_board.valid_placement?(@computer_ships[:cruiser], randomized)
        return @computer_board.place(@computer_ships[:cruiser], randomized)
      end
    end
  end

  def random_computer_board_coordinate(range)
    randomized = @computer_board.cells.keys.shuffle![range]
  end

  def computer_submarine_placement
    loop do
      randomized = random_computer_board_coordinate(0..1)
      if @computer_board.valid_placement?(@computer_ships[:submarine], randomized)
        return @computer_board.place(@computer_ships[:submarine], randomized)
      end
    end
  end

  def print_player_board
    puts @player_board.render(true)
  end

  def print_computer_board
    puts @computer_board.render()
  end

  def player_placement_intro
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    print "The #{@player_ships[:cruiser].name} is #{@player_ships[:cruiser].length} units long and "
    print "the #{@player_ships[:submarine].name} is #{@player_ships[:submarine].length} units long.\n"
  end

  def player_ship_placement
    player_placement_intro
    print_player_board
    player_cruiser_instructions
    player_cruiser_placement
    player_submarine_instructions
    player_submarine_placement
  end

  def player_cruiser_instructions
    p "Enter the squares for the #{@player_ships[:cruiser].name} (#{@player_ships[:cruiser].length} spaces):"
    print "> "
  end

  def player_cruiser_placement
     player_input = gets.chomp.upcase.split(" ")
     if player_input.count == 3 && @player_board.valid_placement?(@player_ships[:cruiser], player_input)
       @player_board.place(@player_ships[:cruiser], player_input)
       print_player_board
     else
       invalid_coordinate_alert
       player_cruiser_placement
     end
  end

  def player_submarine_instructions
    p "Enter the squares for the #{@player_ships[:submarine].name} (#{@player_ships[:submarine].length} spaces):"
    print "> "
  end

  def player_submarine_placement
    player_input = gets.chomp.upcase.split(" ")
    if player_input.count == 2 && @player_board.valid_placement?(@player_ships[:submarine], player_input)
      @player_board.place(@player_ships[:submarine], player_input)
    else
      invalid_coordinate_alert
      player_submarine_placement
    end
  end

  def invalid_coordinate_alert
    p "Those are invalid coordinates. Please try again:"
    print "> "
  end

  def display_board
    p "COMPUTER BOARD".center(50, "=")
    print_computer_board
    p "PLAYER BOARD".center(50, "=")
    print_player_board
  end

  def player_fired_upon(coordinate)
    if !@player_board.cells[coordinate].fired_upon?
      fire_upon_player(coordinate)
    else
      player_fired_upon(@player_board.cells.keys.sample(1).first)
    end
  end

  def fire_upon_player(coordinate)
    @player_board.cells[coordinate].fire_upon
    if @player_board.cells[coordinate].render == "M"
      p "My shot on #{coordinate} was a miss."
    elsif @player_board.cells[coordinate].render == "H"
      p "My shot on #{coordinate} was a direct hit."
    elsif @player_board.cells[coordinate].render == "X"
      p "My shot on #{coordinate} sunk your ship."
    end
  end

  def computer_fired_upon
    puts "Enter the coordinate for your shot: "
    print "> "
    player_input = gets.chomp.upcase
    fire_upon_computer(player_input)
  end

  def fire_upon_computer(player_input)
    if @computer_board.valid_coordinate?(player_input)
      if @computer_board.cells[player_input].fired_upon?
        p "#{player_input} has already been fired upon. Please try again:"
        print "> "
        computer_fired_upon
      else
        player_fire_on_computer(player_input)
      end
    else
      invalid_coordinate_alert
      computer_fired_upon
    end
  end

  def player_fire_on_computer(player_input)
    @computer_board.cells[player_input].fire_upon
    if @computer_board.cells[player_input].render == "M"
      p "Your shot on #{player_input} was a miss."
    elsif @computer_board.cells[player_input].render == "H"
      p "Your shot on #{player_input} was a direct hit."
    elsif @computer_board.cells[player_input].render == "X"
      p "Your shot on #{player_input} sunk my ship."
    end
  end
end
