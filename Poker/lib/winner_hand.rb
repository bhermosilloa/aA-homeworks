module WinnerHand

    private

    HAND_RANKINGS = {
        straight_flush:  9,
        poker:           8,
        full_house:      7,
        flush:           6,
        straight:        5,
        three_of_a_kind: 4,
        two_pair:        3,
        one_pair:        2,
        high_card:       1
    }

    def tie_breaker
        case hand
        when :high_card, :flush
            high_card_tb(cards, hand2.cards)
        when :one_pair, :two_pair
            set_tb(2)
        when :three_of_a_kind, :full_house
            set_tb(3)
        when :straight, :straight_flush
            straight_tb
        when :poker
            set_tb(4)
        end
    end

    def high_card_tb(set_1, set_2)
        set_1.each_with_index do |card1, idx1|
            set_2.each_with_index do |card2, idx2|
                if idx1 == idx2
                    return card1 <=> card2 unless (card1 <=> card2) == 0
                end
            end
        end
        return 0
    end

    def set_tb(n)
        game_cards_1 = cards.select { |card1| cards.count(card1) == n }
        game_cards_2 = hand2.cards.select { |card2| hand2.cards.count(card2) == n }
        result = high_card_tb(game_cards_1, game_cards_2)
        return result unless result == 0
        high_card_tb(cards, hand2.cards)
    end

    def straight_tb
        straight_ranks = ["A", "5", "4", "3", "2"]
        if (cards.map(&:rank) == straight_ranks) && (hand2.cards.map(&:rank) == straight_ranks)
            return 0
        elsif (cards.map(&:rank) == straight_ranks) && !(hand2.cards.map(&:rank) == straight_ranks)
            return -1
        elsif !(cards.map(&:rank) == straight_ranks) && (hand2.cards.map(&:rank) == straight_ranks)
            return 1
        else
            high_card_tb(cards, hand2.cards)
        end
    end

end