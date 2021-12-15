# 'movement' methods for stepping pieces (knights and kings)

module Stepable
    def moves
        arr = []
        self.move_diffs.each do |diff|
            row, col = self.pos
            dx, dy = diff
            row += dy
            col += dx
            pos = [row, col]
            # add pos pair to moves unless the position is blocked by a friendly piece
            # or the position is out of bounds
            if self.board.valid_pos?(pos)
                unless self.board[pos].color == self.color
                    arr << pos
                end
            end
        end
        arr
    end
    
end
