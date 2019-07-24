require_relative "human_player"
require_relative "board"
require_relative "display"
require_relative "invalid_move_error"

require "byebug"

class Game 

  attr_reader :board, :display, :player1, :player2

  def initialize
    @board = Board.new 
    @display = Display.new(@board) 
    @player1 = Player.new(:blue, @display)
    @player2 = Player.new(:magenta, @display)
    @current_player = player1 
  end
  
  def play  
    display.render
    until board.check_mate?(player1.color) || board.check_mate?(player2.color)
      # begin
        until display.cursor.get_input
          display.render 
        end

      #   if board[start_pos].move_dirs.include?(end_pos)
      #     board.move_piece(start_pos, end_pos)
      #   else
      #     raise InvalidMove.new("Invalid move, try again")
      #   end 
      # rescue InvalidMove => e
      #   puts e.message
      #   retry
      # end
      # self.swap_turn!
    end
  end 
  
  def swap_turn!
    current_player = current_player == player1 ? player2 : player1 
  end 

end 

a = Game.new
a.play