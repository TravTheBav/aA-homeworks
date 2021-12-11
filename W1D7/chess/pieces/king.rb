require_relative "piece.rb"
require_relative "stepable.rb"

class King < Piece
    include Stepable

    def symbol
        "K"
    end

    def inspect
        symbol
    end

    protected
    def move_diffs
        [
            [-1,-1],
            [-1,0],
            [-1,1],
            [0,-1],
            [0,1],
            [1,-1],
            [1,0],
            [1,1]
        ]
    end
end