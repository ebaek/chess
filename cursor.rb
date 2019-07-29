require "io/console"

require "byebug"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(board)
    @cursor_pos = []
    @board = board

    @row = cursor_pos[0]
    @col = cursor_pos[1]
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    if key == :ctrl_c 
      Process.exit(0)
      nil
    elsif[:return, :space].include?(key)
      new_pos = [@row, @col]

      if @cursor_pos.length < 2
        @cursor_pos << new_pos
      else
        @cursor_pos = [];
        @cursor_pos << new_pos;
      end
      new_pos
    elsif [:left, :right, :up, :down].include?(key) 
      update_pos(MOVES[key])  
      nil
    end 

  end

  def valid_pos?(pos) 
    row, col = pos 
    debugger
    cur_cursor_pos = cursor_pos[-1]
    cur_cursor_pos[0] += row 
    cur_cursor_pos[1] += col
    cur_cursor_pos.all?{ |el| el.between?(0,7)}    
  end 

  def update_pos(diff)
    row, col = diff
    if valid_pos?(diff)
      @row += row
      @col += col
    end
  end

end