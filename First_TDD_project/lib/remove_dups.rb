def my_uniq(array)
    raise ArgumentError.new("Argument must be an array") unless array.is_a?(Array)
    array.each_with_object([]) do |ele, uniq_array|
        uniq_array << ele unless uniq_array.include?(ele)
    end
end

class Array
    def two_sum
        idx_arr = []
        self.each_with_index do |ele1, idx1|
            self.each.with_index do |ele2, idx2|
                raise ArgumentError.new("All array's elements must be Integers") unless ele2.is_a?(Integer)
                if idx2 > idx1
                    idx_arr << [idx1, idx2] if ele1 + ele2 == 0
                end
            end
        end
        idx_arr
    end
end

def my_transpose(array)
    raise ArgumentError.new("Argument must be an array") unless array.is_a?(Array)
    transposed_array = Array.new(array.size) { Array.new(array.size) }
    array.each_with_index do |row, idx1|
        row.each_with_index do |ele, idx2|
            transposed_array[idx2][idx1] = ele
        end
    end
    transposed_array
end

def stock_picker(array)
    raise ArgumentError.new("Argument must be an array") unless array.is_a?(Array)
    stock_days = []
    biggest_profit = 0
    array.each_with_index do |buy_price, day1|
        array.each_with_index do |sell_price, day2|
            raise ArgumentError.new("All array's elements must be Integers") unless sell_price.is_a?(Integer)
            if day2 > day1
                profit = sell_price - buy_price
                if profit > 0 && profit > biggest_profit
                    biggest_profit = profit
                    stock_days = [day1, day2]
                end
            end
        end
    end
    stock_days
end

class TowersOfHanoi

    attr_accessor :pile_1, :pile_2, :pile_3
    attr_reader :ordered_discs

    def initialize(num_of_discs)
        @ordered_discs = (1..num_of_discs).to_a
        @pile_1 = (1..num_of_discs).to_a
        @pile_2 = []
        @pile_3 = []
    end

    def move(moving_pile, receiving_pile)
        top_disc = moving_pile.first
        if receiving_pile.empty? || (top_disc < receiving_pile.first && moving_pile != receiving_pile)
            top_disc = moving_pile.shift
            receiving_pile.unshift(top_disc) 
        else
            raise InvalidMove
        end
    end

    def won?
        if pile_3 == ordered_discs
            true
        else
            false
        end
    end

    def play
        won = false
        until won?
            begin
                mov, rec = prompt
                move(mov, rec)
            rescue StandardError => e
                puts e.message
                sleep(1)
                retry
            end
        end
        render
        puts "YOU WON!"
    end

    def render
        system("clear")
        puts "Pile 1: #{pile_1.join(" ")}"
        puts "Pile 2: #{pile_2.join(" ")}"
        puts "Pile 3: #{pile_3.join(" ")}"
    end

    def prompt
        render
        puts "What tower do you want to move from?"
        moving_pile = what_pile?
        puts "What tower do you want to move to?"
        receiving_pile = what_pile?
        [moving_pile, receiving_pile]
    end

    def what_pile?
        case gets.to_i
        when 1
            pile_1
        when 2
            pile_2
        when 3
            pile_3
        else
            raise InvalidTower
        end
    end

end

class InvalidMove < StandardError
    def message
        "Invalid move. Try again."
    end
end

class InvalidTower < StandardError
    def message
        "Pick a tower between 1, 2 or 3"
    end
end

if $PROGRAM_NAME == __FILE__
    game = TowersOfHanoi.new(3).play
end