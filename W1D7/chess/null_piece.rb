require_relative 'piece.rb'

class NullPiece < Piece
    def symbol
        "N"
    end

    def inspect
        symbol
    end
end