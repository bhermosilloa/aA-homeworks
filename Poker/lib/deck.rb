require_relative "card"
require_relative "hand"

class Deck

    def self.fill_deck
        cards = []
        Card::SUITS.each do |suit|
            Card::RANKS.each do |rank|
                cards << Card.new(rank, suit)
            end
        end
        cards
    end

    def initialize(cards = Deck.fill_deck)
        @cards = cards
    end

    def deal_hand
        Hand.new(take(5))
    end

    def count
        cards.size
    end

    def take(n)
        raise "not enough cards" unless n <= count
        cards.shift(n)
    end

    def return(return_cards)
        cards.push(*return_cards)
    end

    def shuffle!
        cards.shuffle!
    end

    private

    attr_reader :cards

end