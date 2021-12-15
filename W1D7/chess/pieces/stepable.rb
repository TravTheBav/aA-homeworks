# 'movement' methods for stepping pieces (knights and kings)

module Stepable
    def moves
        positions = []
        self.move_diffs.each do |diff|
            row, col = self.pos
            dx, dy = diff
            row += dy
            col += dx
            # add pos pair to moves unless the position is blocked by a friendly piece
            # or the position is out of bounds
            unless self.board[[row, col]].color == self.color || !in_bounds?(row, col)
                positions << [row, col]
            end
        end
        positions
    end

    # checks to see if a row and column are within the board's boundaries
    def in_bounds?(row, col)
        if row < 0 || row > 7
            return false
        elsif col < 0 || col > 7
            return false
        else
            return true
        end
    end
    
end
