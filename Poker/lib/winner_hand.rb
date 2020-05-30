module WinnerHand

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
        when :high_card
            high_card_tb(cards, hand2.cards)
        when :one_pair
            one_pair_tb
        when :two_pair
            three_and_pairs_tb(2)
        when :three_of_a_kind
            three_and_pairs_tb(3)
        when :straight
            straight_tb
        when :flush
            high_card_tb(cards, hand2.cards)
        when :full_house
            three_and_pairs_tb(3)
        when :poker
            three_and_pairs_tb(4)
        when :straight_flush
            straight_tb
        end
    end

    def high_card_tb(set_1, set_2)
        set_1.each_with_index do |card1, idx1|
            set_2.each_with_index do |card2, idx2|
                if idx1 == idx2
                    if (card1 <=> card2) == 1
                        return 1
                    elsif (card1 <=> card2) == -1
                        return -1
                    end
                end
            end
        end
        return 0
    end

    def one_pair_tb
        card_1 = cards.select { |card1| cards.count(card1) == 2 }.first
        card_2 = hand2.cards.select { |card2| hand2.cards.count(card2) == 2 }.first
        if (card_1 <=> card_2) == 1
            return 1
        elsif (card_1 <=> card_2) == -1
            return -1
        else
            high_card_tb(cards, hand2.cards)
        end
    end

    def three_and_pairs_tb(n)
        game_cards_1 = cards.select { |card1| cards.count(card1) == n }
        game_cards_2 = hand2.cards.select { |card2| hand2.cards.count(card2) == n }
        if high_card_tb(game_cards_1, game_cards_2) == 1
            return 1
        elsif high_card_tb(game_cards_1, game_cards_2) == -1
            return -1
        else
            high_card_tb(cards, hand2.cards)
        end
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