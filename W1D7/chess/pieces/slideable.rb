# 'movement' methods for all sliding pieces (rooks, bishops, queens)

module Slideable
    HORIZONTAL_DIRS = ["up", "down", "left", "right"]
    DIAGONAL_DIRS = ["up-left", "up-right", "down-left", "down-right"]

    def moves
        arr = []
        self.horizontal_dirs.each {|pos| arr << pos}
        self.diagonal_dirs.each {|pos| arr << pos}
        arr
    end

    # returns all moves in horizontal directions
    def horizontal_dirs
        horizontal_moves = []
        self.move_dirs.each do |dir|
            if HORIZONTAL_DIRS.include?(dir)
                case dir
                when "up"
                    dx = 0
                    dy = -1
                when "down"
                    dx = 0
                    dy = 1
                when "left"
                    dx = -1
                    dy = 0
                when "right"
                    dx = 1
                    dy = 0
                end
                moves = grow_unblocked_moves_in_dir(dx, dy)
                moves.each {|move| horizontal_moves << move}
            end
        end
        horizontal_moves
    end

    # returns all moves in diagonal directions
    def diagonal_dirs
        diagonal_moves = []
        self.move_dirs.each do |dir|
            if DIAGONAL_DIRS.include?(dir)
                case dir
                when "up-left"
                    dx = -1
                    dy = -1
                when "up-right"
                    dx = 1
                    dy = -1
                when "down-left"
                    dx = -1
                    dy = 1
                when "down-right"
                    dx = 1
                    dy = 1
                end
                moves = grow_unblocked_moves_in_dir(dx, dy)
                moves.each {|move| diagonal_moves << move}
            end
        end
        diagonal_moves
    end

    # searches for moves in a direction until a piece is found
    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        row, col = self.pos
        row += dy
        col += dx
        pos = [row, col]
        return moves if !self.board.valid_pos?(pos)
        # increment initial position by dx/dy and then keep adding positions
        # until another piece is hit
        while self.board[pos].is_a?(NullPiece) && self.board.valid_pos?(pos)
            moves << pos
            row += dy
            col += dx
            pos = [row, col]
        end
        
        # if the last position was a valid space, check if it was a friendly piece
        if self.board.valid_pos?(pos)
            unless self.board[pos].color == self.color
                moves << pos
            end
        end
        moves
    end

end
