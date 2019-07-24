require_relative "board"

module Stepable

  KNIGHT_DIRS = [[2,1], [2,-1], [1,-2], [1,2], [-1,-2], [-1, 2], [-2, 1], [-2, -1]]
  KING_DIRS = [[-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0]]
  
  def knight_moves
    moves = []
    KNIGHT_DIRS.each do |k_move|
        x, y = pos
        x += k_move.first 
        y += k_move.last
        if on_board?([x,y]) && !taken?([x,y])  
          moves << [x, y]
        end
      end
    moves
  end

  def king_moves 
    moves = []
    KING_DIRS.each do |king_move|
        x, y = pos
        x += king_move.first 
        y += king_move.last
        while on_board?([x,y]) && !taken?([x,y])  
          moves << [x, y]
        end
      end
    moves
  end

  def on_board?(p)
    p.all? { |ele| ele.between?(0, 7) }
  end

  def taken?(p)
    board[p].symbol != " "
  end

end