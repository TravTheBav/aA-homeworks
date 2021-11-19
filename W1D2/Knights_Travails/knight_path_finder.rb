require_relative 'poly_tree_node.rb'

class KnightPathFinder
    def self.valid_moves(pos)
        start_x, start_y = pos
        positions = []
        8.times do |x|
            8.times do |y|
                if (start_x + 2 == x || start_x - 2 == x) &&
                    (start_y + 1 == y || start_y - 1 == y)
                        positions << [x, y]
                elsif (start_x + 1 == x || start_x - 1 == x) &&
                    (start_y + 2 == y || start_y - 2 == y)
                        positions << [x, y]
                end
            end
        end
        positions
    end

    def initialize(pos)
        @starting_pos = pos
        @root_node = PolyTreeNode.new(@starting_pos)
        @considered_positions = [@starting_pos]
    end

    def build_move_tree
        # TO DO
    end


end