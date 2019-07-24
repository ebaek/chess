require_relative "board"
class Piece 

  attr_reader :color, :board 

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  # def empty?
  # end

  def symbol
    " "
  end 

  def pos=(value)
    board[pos] = value
  end

  def update_pos(new_pos)
    self.pos = new_pos
  end

  def make_dirs 
    []
  end

  private
  attr_reader :board, :pos
end 