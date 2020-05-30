# require "colorize"

class Card

    SUITS = %i(spades diamonds hearts clubs).freeze
    RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze

    attr_reader :rank, :suit

    def initialize(rank, suit)
        raise "Invalid suit" unless RANKS.include?(rank) && SUITS.include?(suit)
        @rank, @suit = rank, suit
    end

    def to_s
        case suit
        when :spades
            # "#{rank}♠".black.on_light_white.bold - colorized cards
            "#{rank}♠"
        when :diamonds
            # "#{rank}♦".light_blue.on_light_white.bold
            "#{rank}♦"
        when :hearts
            # "#{rank}♥".light_red.on_light_white.bold
            "#{rank}♥"
        when :clubs
            # "#{rank}♣".green.on_light_white.bold
            "#{rank}♣"
        end
    end

    def ==(card2)
        rank == card2.rank
    end

    def <=>(card2)
        return 0 if self == card2
        return 1 if RANKS.index(rank) > RANKS.index(card2.rank)
        return -1 if RANKS.index(rank) < RANKS.index(card2.rank)
    end

end