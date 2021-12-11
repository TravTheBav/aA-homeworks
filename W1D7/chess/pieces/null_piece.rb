require_relative 'piece.rb'
require 'singleton.rb'

class NullPiece < Piece
    include Singleton
    def initialize
        @color = nil
        @symbol = "N"
    end
    
    def symbol
        @symbol
    end

    def inspect
        symbol
    end
end