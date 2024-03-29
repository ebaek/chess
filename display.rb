require_relative "board"
require "colorize"
require_relative "cursor"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new(board)
  end

  def render
    system("clear")
    full_board = "";

    puts " #{("A".."H").to_a.join(" ")}"
    8.times do |row|
      str = [row]
      8.times do |col|
        piece = board[[row, col]]
        if row.even?
          if col.even? 
            str << "#{piece.symbol} ".colorize(:color => piece.color, :background => :white)
          else
            str << "#{piece.symbol} ".colorize(:color => piece.color, :background => :black)
          end 
        else
          if col.even? 
            str << "#{piece.symbol} ".colorize(:color => piece.color, :background => :black)
          else
            str << "#{piece.symbol} ".colorize(:color => piece.color, :background => :white)
          end 
        end 
        # debugger
        str[col+1] = "#{piece.symbol} ".colorize(:background => :light_yellow) if @cursor.cursor_pos == [row, col]
    end
    full_board += str.join + "\n"
    end

    print "#{full_board}"
  end

end



