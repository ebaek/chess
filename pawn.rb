require_relative "piece"

class Pawn < Piece

  BLUE_MOVES = [[1,0], [1,1], [1,-1]] 
  MAGENTA_MOVES = [[-1,0], [1,1], [-1,1]]

  def initialize(color, board, pos)
    @start_row = true 
    super
  end

  def symbol
    "\u265F".encode('utf-8');
  end

  def forward_steps
    std = []
    if color == :magenta
      std += pawn_moves(MAGENTA_MOVES) 
      if start_row
        std += pawn_moves([[-2,0]]) 
        self.start_row = false
      end
    end
    if color == :blue 
      std.concat pawn_moves(BLUE_MOVES)
      if start_row
        std += pawn_moves([[2,0]]) 
        self.start_row = false
      end
    end
    std
  end

  def pawn_moves(moves)
    row, col = pos 
    current_moves = [] 
    enemy_color = color == :blue ? :magenta : :blue
    moves.each do |move|
      temp_pos = [row + move.first, col + move.last]
      if on_board?(temp_pos) 
        if taken?(temp_pos) && board[temp_pos] == enemy_color
          current_moves << temp_pos
        elsif !taken?(temp_pos) && move.last == 0
          current_moves << temp_pos
        end
      end
    end 
    current_moves
  end

  private
  attr_reader :start_pos, :start_row 
  attr_writer :start_row

  # def start_jump
  #   if color = :blue

  #   end


  # end

  def on_board?(p)
    p.all? { |ele| ele.between?(0, 7) }
  end

  def taken?(p)
    board[p].symbol != " "
  end

end