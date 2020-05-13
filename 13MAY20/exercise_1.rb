class Stack
    def initialize
      @stack = []
    end

    def push(el)
      @stack << el
    end

    def pop
      @stack.pop
    end

    def peek
      @stack.last
    end
end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue.first
    end
end

class Map
    def initialize
        @map = []
    end

    def set(key, value)
        include_key = false
        @map.each do |set| 
            if set.include?(key)
                set[1] = value 
                include_key = true
            end
        end
        @map << [key, value] unless include_key
        value
    end

    def get(key)
        @map.each { |set| return set[1] if set[0] == key }
        nil
    end

    def delete(key)
        @map.each do |set| 
            if set[0] == key
                value = set[1]
                @map.delete(set)
                return value
            end
        end
        nil
    end

    def show
        @map.map { |pair| pair }
    end
end