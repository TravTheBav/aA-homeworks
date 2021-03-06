require_relative "piece.rb"
require_relative "slideable.rb"

class Queen < Piece
    include Slideable

    def symbol
        "Q"
    end

    private
    def move_dirs
        [
            "up", "down", "left", "right",
            "up-left", "up-right", "down-left", "down-right"
        ]
    end

end
