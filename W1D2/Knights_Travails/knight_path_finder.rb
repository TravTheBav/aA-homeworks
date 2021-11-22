require_relative 'poly_tree_node.rb'

class KnightPathFinder
    attr_reader :starting_pos, :root_node, :considered_positions

    # returns all valid moves in an 8x8 board
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

    # builds the entire move tree starting at the root_node
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

    # uses bfs to get from root_node to the last node in the search tree
    def find_path(end_pos)
        build_move_tree
        last_node = root_node.bfs(end_pos)
        p trace_path_back(last_node)
    end

    def trace_path_back(end_node)
        path = []
        current_node = end_node
        until current_node.parent.nil?
            path.unshift(current_node)
            current_node = current_node.parent
        end
        path.unshift(root_node)
        path      
    end
end

# for testing
# start = [0,0]
# end_pos = [6,2]
# kpf = KnightPathFinder.new(start)
# kpf.find_path(end_pos)