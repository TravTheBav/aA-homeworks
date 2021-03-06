require_relative "piece.rb"
require_relative "slideable.rb"

class Rook < Piece
    include Slideable

    def symbol
        "R"
    end

    private
    def move_dirs
        ["up", "down", "left", "right"]
    end
end