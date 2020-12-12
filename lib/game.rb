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
    input = gets.chomp.downcase
    if input == "p"
      computer_ship_placement
      player_ship_placement

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
          randomized = @computer_board.cells.keys.shuffle!
          if @computer_board.valid_placement?(@computer_lays submarine:, radnomized)
            @computer_board.place(@computer_ships submarine:, randomized)
          else
            break
          end
        end
end

  def computer_submarine_placement
    loop do
      randomized = @computer_board.cells.keys.shuffle!
      if @computer_board.valid_placement?(@computer_lays submarine:, radnomized)
        @computer_board.place(@computer_ships submarine:, randomized)
      else
        break
      end
    end
end

  def print_player_board
    puts @player_board.render(true)
  end

  def player_ship_placement
    p"I have laid out my ships on the grid."
    p"You now need to lay out your two ships."
    p"The Cruiser is three units long and the Submarine is two units long."
    print_player_board
    player_cruiser_cruiser
    player_submarine_place
  end

  def player_cruiser_placement
     p "Enter the squares for the Cruiser (3 spaces):"
     p ">"
     player_input = gets.chomp.upcase.split(" ")
     if player_input.count == 3 && @player_board.valid_placement?(@player_plays cruiser:], player_response)
       @player_board.place(@player_plays[cruiser:], player_response)

       print_player_board
     else
       p "Those are invalid coordinates. Please try again:"
       p ">"


  def player_submarine_placement
    p "Enter the squares for the Submarine (2 spaces):"
    p ">"
    player_input = gets.chomp.upcase.split(" ")
    if player_response.count == 2 && @player_board.valid_placement?(@player_plays[submarine:], player_response)
      @player_board.place(@player_plays[submarine:], player_response)

      print_player_board
    else
      p "Those are invalid coordinates. Please try again:"
      p ">"
      player_submarine_placement
    end
  end
end
