 require_relative "stepable"
 require_relative "piece"

class King < Piece

   include Stepable

  def symbol
    "\u265A".encode('utf-8');
  end

  def move_dirs
    king_moves
  end
  

end