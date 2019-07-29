require_relative "human_player"
require_relative "board"
require_relative "display"
require_relative "invalid_move_error"

require_relative "cursor"

require "byebug"

class Game 

  attr_reader :board, :display, :player1, :player2, :cursor, :current_player

  def initialize
    @board = Board.new 
    @display = Display.new(@board) 
    @player1 = Player.new(:blue, @display)
    @player2 = Player.new(:magenta, @display)
    @current_player = player1 

  end
  
  def play  
    until board.check_mate?(player1.color) || board.check_mate?(player2.color)
      move 
    end 
  

      #   else
      #     raise InvalidMove.new("Invalid move, try again")
      #   end 
      # rescue InvalidMove => e
      #   puts e.message
      #   retry
      # end
      
  end
  
  def move
    start_pos = nil
    display.render
    
    until start_pos && board[start_pos].color == current_player.color
      start_pos = display.cursor.get_input
      display.render
    end

    end_pos = nil

    until end_pos && start_pos != end_pos
      end_pos = display.cursor.get_input
      display.render
    end
    
    if board[start_pos].move_dirs.include?(end_pos)
      board[start_pos].update_pos(end_pos)
      board.move_piece(start_pos, end_pos)
      display.render
      self.swap_turn!
    end 
  end
  
  def swap_turn!
    @current_player = current_player == player1 ? player2 : player1 
  end 

end 

a = Game.new
a.play