require 'byebug'

class Board
  
  attr_accessor :cups
  attr_reader :name1, :name2, :player_store_index

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    @name1 = name1
    @name2 = name2

    place_stones
  end

  def valid_move?(start_pos)
    if start_pos.between?(0, 12)
      if @cups[start_pos].empty?
        raise "Starting cup is empty"
      else
        true
      end
    else
      raise "Invalid starting cup"
    end
  end
  
  def make_move(start_pos, current_player_name)
    opponent_store_index = current_player_name == self.name1 ? 13 : 6
    @player_store_index = opponent_store_index == 6 ? 13 : 6
    stone_count = @cups[start_pos].length
    @cups[start_pos] = []
    while stone_count > 0
      start_pos = (start_pos + 1) % 14
      if start_pos != opponent_store_index
        @cups[start_pos] << :stone
        stone_count -= 1
      end
    end
    self.render
    self.next_turn(start_pos)
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    who = @cups[6].length <=> @cups[13].length
    if who == 1
      self.name1
    elsif who == -1
      self.name2
    else
      :draw
    end
  end

  def place_stones
    @cups.each_index { |idx| 4.times { @cups[idx] << :stone } if idx != 6 && idx != 13 }
  end

  def next_turn(ending_cup_idx)
    return :prompt if ending_cup_idx == self.player_store_index
    @cups[ending_cup_idx].length > 1 ? ending_cup_idx : :switch
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

end
