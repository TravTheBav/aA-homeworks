class PolyTreeNode
    attr_reader :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        old_parent = parent
        if !parent.equal?(parent_node) # failsafe incase parent is added twice
            @parent = parent_node
            return if parent_node.nil? # ends early if setting parent to nil
            parent_node.children << self # add self to new parents children
            if !old_parent.nil? #remove self from old parents children if old parent not nil
                old_parent.children.delete(self) 
            end
        end
    end

end