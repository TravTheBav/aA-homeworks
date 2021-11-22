require_relative 'poly_tree_node.rb'

class KnightPathFinder
    attr_reader :starting_pos, :root_node, :considered_positions

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

    # checks for all valid positions that haven't been considered yet
    # adds these positions to the considered positions and returns these positions
    def new_move_positions(pos)
        new_positions = KnightPathFinder.valid_moves(pos).select { |coord| @considered_positions.include?(coord) == false }
        new_positions.each { |coord| @considered_positions << coord }
        new_positions
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            current_node = queue.shift
            new_move_positions(current_node.value).each do |pos|
                new_node = PolyTreeNode.new(pos)
                current_node.add_child(new_node)
                queue << new_node
            end
        end
    end

end