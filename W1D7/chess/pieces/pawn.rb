require_relative 'piece.rb'

class Pawn < Piece
    def symbol
        "P"
    end

    def inspect
        symbol
    end

    def moves
        arr = []
        row = self.pos[0]
        col = self.pos[1]
        forward_steps.each do |step|
            next_row = row + (step * self.forward_dir)
            pos = [next_row, col]
            arr << pos if self.board[pos].is_a?(NullPiece) # can only move forward to empty spaces
        end
        side_attacks.each do |y|
            attack_row = row + forward_dir
            attack_col = col + y
            pos = [attack_row, attack_col]
            unless self.board[pos].color == self.color || self.board[pos].is_a?(NullPiece)
                arr << pos
            end
        end
        arr
    end

    private
    def at_start_row?
        row_idx = 0
        if self.color == "black" && self.pos[row_idx] == 1
            return true
        elsif self.color == "white" && self.pos[row_idx] == 6
            return true
        else
            return false
        end
    end

    def forward_dir
        if self.color == "black"
            return 1
        else
            return -1
        end
    end

    def forward_steps
        if at_start_row?
            return [1, 2]
        else
            return [1]
        end
    end

    def side_attacks
        return [1, -1]
    end

end
