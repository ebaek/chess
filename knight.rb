 
 require_relative "stepable"
 require_relative "piece"
 
class Knight < Piece

  include Stepable

  def symbol
    "\u265E".encode('utf-8');
  end

  def move_dirs
    knight_moves
  end

end