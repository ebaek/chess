require_relative "pawn"
require_relative "rook"
require_relative "bishop"
require_relative "queen"
require_relative "knight"
require_relative "king"
require_relative "null_piece"


require "byebug"

class Board 
  attr_reader :grid

  def initialize 
    @grid = Array.new(8){ Array.new(8)}
    @sentinel = NullPiece.instance
    set_board
  end 

  def move_piece(start_pos, end_pos)
    debugger
    if self[start_pos] && self[end_pos].is_a?(NullPiece)
      start_pos_piece = self[start_pos]
      self[end_pos] = start_pos_piece
      self[start_pos] = sentinel
    end
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def [](pos) 
    row, col = pos 

    @grid[row][col]
  end

  def check_mate?(color)
    king_pos = find_king_pos(color)

    if in_check?(color, king_pos)
      board[king_pos].move_dirs.all? do |direction| 
        in_check?(color, direction)
      end 
    end 
  end

  private 
  attr_reader :sentinel 

  def set_board
    8.times do |row|
      if row.between?(2, 5)
        grid[row].fill(sentinel)
      end 
      8.times do |col|
        if !row.between?(2,5) 
          pos = [row, col]
          self[pos] = Piece.new(:red, self, pos)
        end
      end
    end
    place_pawns 
    place_backrow(:magenta, 7)
    place_backrow(:blue, 0)
  end

  def place_pawns 
    8.times do |x|
      if x == 6
        8.times { |y| self[[x,y]] = Pawn.new(:magenta, self, [x, y]) }
      elsif x == 1
        8.times { |y| self[[x,y]] = Pawn.new(:blue, self, [x, y]) }
      end
    end
  end
  
  def place_backrow(color, row) 
    self[[row, 0]] = Rook.new(color, self, [row, 0])
    self[[row, 1]] = Knight.new(color, self, [row, 1])
    self[[row, 2]] = Bishop.new(color, self, [row, 2])
    self[[row, 3]] = King.new(color, self, [row, 3])
    self[[row, 4]] = Queen.new(color, self, [row, 4])
    self[[row, 5]] = Bishop.new(color, self, [row, 5])
    self[[row, 6]] = Knight.new(color, self, [row, 6])
    self[[row, 7]] = Rook.new(color, self, [row, 7])
  end
  
  def in_check?(color, pos)
     check_helper(pos, color)
  end

  def check_helper(king_pos, color) 
    opp_color = opposing_color(color)
    grid.each do |row| 
      row.each do |col| 
        if col.color == opp_color
          return true if col.make_dirs.include?(king_pos)
        end
      end 
    end 
    false
  end
  
  def find_king_pos(color)
    king_pos = [] 

    grid.each_with_index do |row, idx1| 
      row.each_with_index do |col, idx2| 
        king_pos = [idx1, idx2] if col.is_a?(King) && col.color == color 
      end 
    end
  end 
 
  def opposing_color(color)
    return color == :blue ? :magenta : :blue
  end 

end

