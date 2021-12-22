Dir['pieces/*.rb'].each {|file| require_relative file}

class Board
    attr_reader :rows

    def initialize
        @rows = Array.new(8) { Array.new(8) }
        black_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        white_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        @rows.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                pos = [row_idx, col_idx]
                if row_idx == 0
                    piece = black_pieces.shift
                    piece = piece.new(:black, self, pos)
                elsif row_idx == 7
                    piece = white_pieces.shift
                    piece = piece.new(:white, self, pos)
                elsif row_idx == 1
                    piece = Pawn.new(:black, self, pos)
                elsif row_idx == 6
                    piece = Pawn.new(:white, self, pos)
                else
                    piece = NullPiece.instance
                end
                add_piece(piece, pos)
            end
        end
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @rows[row][col] = piece
    end

    def move_piece(color, start_pos, end_pos)
        if self[start_pos].is_a?(NullPiece)
            puts "must start with an occupied tile"
        else
            piece = self[start_pos]
            if piece.moves.include?(end_pos) 
                self[end_pos] = piece
                piece.pos = end_pos
                self[start_pos] = NullPiece.instance
            else
                puts "invalid end position"
            end
        end
    end

    def valid_pos?(pos)
        pos.none? { |num| num > 7 || num < 0 }
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

end
