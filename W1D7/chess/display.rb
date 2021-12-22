require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        board.rows.each_with_index do |row, row_idx|
            row.each_with_index do |piece, col_idx|
                
                if [row_idx, col_idx] == cursor.cursor_pos
                    if cursor.selected
                        background_color = :green
                    else
                        background_color = :blue
                    end
                else
                    background_color = :light_blue
                end

                if piece.color.nil?
                    piece_color = background_color
                else
                    piece_color = piece.color
                end

                print piece.to_s.colorize(:color => piece_color, :background => background_color)
            end
            puts
        end
        nil
    end

    # def test_cursor
    #     while true
    #         render
    #         cursor.get_input
    #         system("clear")
    #     end        
    # end
end
