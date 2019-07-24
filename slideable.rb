require_relative "piece"


module Slideable

  attr_reader :HORIZONTAL_DIRS, :VERTICAL_DIRS, :DIAGONAL_DIRS   

  HORIZONTAL_DIRS = [[0,-1], [0,1]]
  VERTICAL_DIRS = [[-1,0], [1,0]]
  DIAGONAL_DIRS = [[1,1], [1,-1], [-1,-1], [-1,1]]


  def move_dirs   
  end
  

  def horizontal_vertical_moves 
    moves = [] 
    HORIZONTAL_DIRS.each do |h_move|
        x, y = pos
        y += h_move.last
        while on_board?([x,y]) && !taken?([x,y])  
          moves << [x, y]
          y += h_move.last
        end
    end
  
    VERTICAL_DIRS.each do |v_move|
        x, y = pos
        x += v_move.first
        while on_board?([x,y]) && !taken?([x,y])  
          moves << [x, y]
          x += v_move.first
        end
    end
    moves 
  end


  def diagonal_moves 
    moves = []
    DIAGONAL_DIRS.each do |d_move|
        x, y = pos
        x += d_move.first 
        y += d_move.last

        while on_board?([x,y]) && !taken?([x,y])  
          moves << [x, y]
          x += d_move.first 
          y += d_move.last
        end
    end
    moves
  end 

  def move

  end


  def on_board?(p)
    p.all? { |ele| ele.between?(0, 7) }
  end

  def taken?(p)
    board[p].symbol != " "
  end

end