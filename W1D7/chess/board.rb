require_relative "piece"

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        @grid.each_with_index do |row, idx|
            if [0, 1, 6, 7].include?(idx)
                row.map! { Piece.new }
            end
        end
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @grid[row][col] = piece
    end

    def move_piece(start_pos, end_pos)
        if self[start_pos].nil?
            puts "must start with an occupied tile"
        elsif self[end_pos].is_a?(Piece)
            puts "must move to an empty tile"
        else
            piece = self[start_pos]
            self[end_pos] = piece
            self[start_pos] = nil
        end
    end
end