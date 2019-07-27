require_relative "slideable"
require_relative "piece"

class Rook < Piece
   include Slideable

   def move_dirs
    horizontal_vertical_moves 
   end

   def symbol
      "\u265C".encode('utf-8');
    end

end