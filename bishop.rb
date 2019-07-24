require_relative "slideable"
require_relative "piece"

class Bishop < Piece

  include Slideable

  def move_dirs
    diagonal_moves
  end

  def symbol
    "\u265D".encode('utf-8');
  end

end 