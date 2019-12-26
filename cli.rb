require "./board"

class CLI
    attr_reader :board

    def initialize
        @board = Board.new
    end

    def new_game_prompt
      puts "Welcome to Tic Tac Toe!"
      puts "Would you like to play a game?"
      puts "y/n"
      y_or_n_prompt_for_new_game
    end

    def y_or_n_prompt_for_new_game
      board.reset
      response = gets.strip.downcase
      case response
        when "y"
          puts "Would you like to go first?"
          puts "y/n"
          y_or_n_prompt_for_first_turn
        when "n"
          puts "Goodbye!"
        else
          puts "Sorry but #{response} is not a valid answer"
          puts "Please enter y/n"
          y_or_n_prompt_for_new_game
      end
    end

    def y_or_n_prompt_for_first_turn
      response = gets.strip.downcase
      case response
        when "y"
          user_turn_prompt
        when "n"
          computer_turn
        else
          puts "Sorry but #{response} is not a valid answer"
          puts "Please enter y/n"
          y_or_n_prompt_for_new_game
      end
    end

    def user_turn_prompt
      board.print
      puts "Your turn! Please select a tile such as a1 or 3C"
      tile = gets.strip
      begin
        board.take_space_via_tile(tile, "X")
      rescue
        puts "Your selection of #{tile} is invalid. Please select again"
        return user_turn_prompt
      end
      computer_turn
    end

    def user_turn
      if board.has_winner?
        winner = board.find_winner
        if winner == "O"
          puts "The computer won! Would you like to play again?"
          puts "y/n"
          y_or_n_prompt_for_new_game
        else
          puts "You somehow beat an unbeatable game of Tic Tac Toe.."
          sleep 1
          puts "We double checked. You're a true champion. We're putting this processor out to pasture"
          puts "In the meantime, have a good life as Tic Tac Toe Grandmaster 👋"
        end
      elsif board.is_board_full?
        puts "Looks like it's a tie; would you like to play again?"
        puts "y/n"
        y_or_n_prompt_for_new_game
      else
        user_turn_prompt
      end
    end

    def computer_turn
      if board.has_winner?
        winner = board.find_winner
        if winner == "O"
          puts "The computer won! Would you like to play again?"
          puts "y/n"
          y_or_n_prompt_for_new_game
        else
          puts "You somehow beat an unbeatable game of Tic Tac Toe..."
          sleep 1
          puts "We double checked. You're a true champion. We're putting this processor out to pasture"
          puts "In the meantime, have a good life as Tic Tac Toe Grandmaster 👋"
        end
      elsif board.is_board_full?
        puts "Looks like it's a tie; would you like to play again?"
        puts "y/n"
        y_or_n_prompt_for_new_game
      else
        puts "COMPUTER TURN"
        user_turn
      end
    end
end
