class Queue
    def initialize # a queue is represented by an array
        @arr = []
    end

    def enqueue(el) # adds an element to the end of the queue
        @arr << el
    end

    def dequeue # removes first element in the queue
        @arr.shift
    end

    def peek    # returns the first element to be removed
        @arr[0]
    end
end