Dir['pieces/*.rb'].each {|file| require_relative file}

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        black_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        white_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        @grid.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                if row_idx == 0
                    next_piece = black_pieces.shift
                    @grid[row_idx][col_idx] = next_piece.new("black", self, [row_idx, col_idx])
                elsif row_idx == 7
                    next_piece = white_pieces.shift
                    @grid[row_idx][col_idx] = next_piece.new("white", self, [row_idx, col_idx])
                elsif row_idx == 1
                    @grid[row_idx][col_idx] = Pawn.new("black", self, [row_idx, col_idx])
                elsif row_idx == 6
                    @grid[row_idx][col_idx] = Pawn.new("white", self, [row_idx, col_idx])
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
        if self[start_pos].is_a?(NullPiece)
            puts "must start with an occupied tile"
        else
            piece = self[start_pos]
            if piece.moves.include?(end_pos) 
                self[end_pos] = piece
                self[start_pos] = NullPiece.instance
            else
                puts "invalid end position"
            end
        end
    end
    
end
