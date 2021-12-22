require_relative "piece.rb"
require_relative "slideable.rb"

class Bishop < Piece
    include Slideable

    def symbol
        "B"
    end

    private
    def move_dirs
        ["up-left", "up-right", "down-left", "down-right"]
    end

end
