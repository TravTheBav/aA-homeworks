Dir['pieces/*.rb'].each {|file| require_relative file}

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        @grid.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                if [0, 1].include?(row_idx)
                    @grid[row_idx][col_idx] = King.new("white", self, [row_idx, col_idx])
                elsif [6, 7].include?(row_idx)
                    @grid[row_idx][col_idx] = Rook.new("black", self, [row_idx, col_idx])
                else
                    @grid[row_idx][col_idx] = NullPiece.instance
                end
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
        else
            piece = self[start_pos]
            if piece.moves.include?(end_pos) 
                self[end_pos] = piece
                self[start_pos] = nil
            else
                puts "invalid end position"
            end
        end
    end

end