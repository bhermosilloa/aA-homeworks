# Big O-ctopus and Biggest Fish

def sluggish_octopus(fish)
    bigger_fish = fish.first
    fish.each_with_index do |fish_1, idx1|
        fish.each_with_index do |fish_2, idx2|
            if idx2 > idx1
                bigger_fish = fish_2 if fish_2.length >= fish_1.length
            end
        end
    end
    bigger_fish
end

def dominant_octopus(fish)
    return fish.first if fish.count == 1
    next_dominant = dominant_octopus(fish[1..-1])
    bigger_fish = fish.first.length > next_dominant.length ? fish.first : next_dominant
    bigger_fish
end

def clever_octopus(fish)
    bigger_fish = fish.first
    fish.each { |fish_ele| bigger_fish = fish_ele if fish_ele.length >= bigger_fish.length }
    bigger_fish
end

array = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'] * 1255 + ['ffffffffffffffiiiiiiiiiiiiisssssssshhhhhhhh']

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Clever =>   #{clever_octopus(array)}"
finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts finish - start

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Dominant => #{dominant_octopus(array)}"
finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts finish - start

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Sluggish => #{sluggish_octopus(array)}"
finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts finish - start


# Dancing Octopus

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(direction, tiles)
    tiles.each_with_index { |dir, idx| return idx if dir == direction }
end

new_tiles_data_structure = {
    "up" => 0,
    "right-up" => 1,
    "right" => 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def fast_dance(direction, tiles)
    tiles[direction]
end

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts slow_dance("up", tiles_array)
puts slow_dance("right-down", tiles_array)
finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts (finish - start)*1000000

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts fast_dance("up", new_tiles_data_structure)
puts fast_dance("right-down", new_tiles_data_structure)
finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts (finish - start)*1000000