require "singleton"
require_relative "piece"

class NullPiece < Piece 
  include Singleton

  def initialize
    @symbol = " " 
    @color = :none 
  end 
end