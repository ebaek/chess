require_relative "slideable"
require_relative "piece"

class Queen < Piece

  include Slideable

    def move_dirs
      horizontal_vertical_moves + diagonal_moves
    end

    def symbol
      "\u265D".encode('utf-8');
    end

end