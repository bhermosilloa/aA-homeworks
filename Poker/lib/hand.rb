require_relative "poker_hands"

class Hand

    include PokerHands

    attr_reader :cards

    def initialize(cards)
        raise "Hand has to have 5 cards" unless cards.count == 5
        @cards = cards
        bubble_sort_cards
    end

    def self.winner(hands)
        hands.sort.last
    end

    def hand
        which_hand
    end

    def to_s
        cards.join(" ")
    end

    def change_cards(trash_cards, new_cards)
        raise "hand must have five cards" unless trash_cards.count == new_cards.count
        raise "invalid trashed card - must throw existing card" unless include_cards?(trash_cards)
        throw_cards_away(trash_cards) && receive(new_cards) && bubble_sort_cards
        trash_cards
    end

    def ==(hand2)
        hand == hand2.hand
    end

    def <=>(hand2)
        if self == hand2
            @hand2 = hand2
            return tie_breaker
        end
        return 1 if HAND_RANKINGS[hand] > HAND_RANKINGS[hand2.hand]
        return -1 if HAND_RANKINGS[hand] < HAND_RANKINGS[hand2.hand]
    end

    private
    
    attr_reader :hand2

    def throw_cards_away(trash_cards)
        trash_cards.each { |card| cards.delete(card) }
    end

    def receive(new_cards)
        new_cards.each { |card| cards.push(card) }
    end

    def include_cards?(selected_cards)
        selected_cards.all? { |card| cards.include?(card) }
    end

end

class Array

    # The original Array#delete method, when asked to delete a certain
    # card from a hand, it deleted all cards with the same value included
    # in the hand. So I overrided it.

    def delete(object)
        self.reject! { |ele| ele.object_id == object.object_id }
    end

end