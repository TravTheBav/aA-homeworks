require 'colorize'

# a parent class for all piece objects
class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def pos=(val)
        @pos = val
    end

    def to_s
        self.symbol
    end

end
