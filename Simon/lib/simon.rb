require "colorize"

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until @game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      system("clear")
      sleep(0.05)
      print color.upcase.colorize(color.to_sym).on_light_white.bold
      sleep(1)
    end
  end

  def require_sequence
    index = 0
    entered_sequence = []
    while index < @sequence_length
      system("clear")
      print ">> "
      entered_sequence << gets.chomp.downcase
      if @seq[index] == entered_sequence.last
        index += 1
      else
        @game_over = true
        break
      end
    end
    round_success_message if !@game_over
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    system("clear")
    print "Grat job! Round complete!"
    sleep(1)
  end

  def game_over_message
    system("clear")
    print "WRONG ANSWER! GAME OVER! You lasted #{@sequence_length} rounds!"
    sleep(1)
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
