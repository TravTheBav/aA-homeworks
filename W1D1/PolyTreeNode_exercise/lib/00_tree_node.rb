class PolyTreeNode
    attr_reader :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
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
        @children << child_node unless @children.include?(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "arg must be a child" if children.include?(child_node) == false
        @children.delete(child_node)
        child_node.parent = nil            
    end

end