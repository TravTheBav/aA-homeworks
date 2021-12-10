require_relative "piece.rb"
require_relative "slideable.rb"

class Bishop < Piece
    include Slideable

    def initialize(color, board, pos)
        super
    end

    def symbol
        "B"
    end

    def inspect
        symbol
    end

    private
    def move_dirs
        ["up-left", "up-right", "down-left", "down-right"]
    end
end