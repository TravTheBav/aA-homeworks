class Map
    def initialize
        @arr = []
    end

    def set(key, value)
        @arr.each do |pair| # first check to see if key value pair already exists
            if pair.include?(key) # if it does then update it
                pair[1] = value
                return
            end
        end
        @arr << [key, value] # add pair if it doesn't exist
    end

    def get(key)
        @arr.each do |pair|
            return pair[1] if pair.include?(key) # returns the value mapped to key
        end
        nil # returns nil if map doesn't contain key
    end

    def delete(key) # deletes key/value pair from the map
        @arr.each do |pair|
            @arr.delete(pair) if pair.include?(key)
        end
    end

    def show   # dipslays map to terminal
        p @arr
        nil
    end
end
