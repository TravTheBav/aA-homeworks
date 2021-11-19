class PolyTreeNode
    attr_reader :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    
    def inspect
        @value.inspect
    end

    def parent=(parent_node)
        old_parent = parent
        unless parent.equal?(parent_node) # failsafe incase parent is added twice
            @parent = parent_node
            return if parent_node.nil? # ends early if setting parent to nil
            parent_node.children << self # add self to new parents children
            unless old_parent.nil? #remove self from old parents children if old parent not nil
                old_parent.children.delete(self) 
            end
        end
    end

    def add_child(child_node)
        child_node.parent = self unless children.include?(child_node)
    end

    def remove_child(child_node)
        raise "arg must be a child" if children.include?(child_node) == false
        @children.delete(child_node)
        child_node.parent = nil            
    end

    def dfs(target_value)
        return self if value == target_value
        children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            first_node = queue.shift
            return first_node if first_node.value == target_value
            first_node.children.each { |child| queue << child }
        end
        nil
    end

end