require "byebug"

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
        return moves if !in_bounds?(row, col)
        # increment initial position by dx/dy and then keep adding positions
        # until another piece is hit
        while self.board[[row, col]].is_a?(NullPiece) && in_bounds?(row, col)
            moves << [row, col]
            row += dy
            col += dx
        end
        
        # if the last position was a friendly piece, don't add it to positions
        if self.board[[row, col]].color != self.color && in_bounds?(row, col)
            moves << [row, col]
        end
        moves
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