require_relative "winner_hand"

module PokerHands

    include WinnerHand

    private

    NEXT_RANKS = {
        "A" => "K",
        "2" => "A",
        "3" => "2",
        "4" => "3",
        "5" => "4",
        "6" => "5",
        "7" => "6",
        "8" => "7",
        "9" => "8",
        "10" => "9",
        "J" => "10",
        "Q" => "J",
        "K" => "Q"
    }
    
    def which_hand
        if straight_flush
            :straight_flush
        elsif poker
            :poker
        elsif full_house
            :full_house
        elsif flush
            :flush
        elsif straight
            :straight
        elsif three_of_a_kind
            :three_of_a_kind
        elsif two_pair
            :two_pair
        elsif pair
            :one_pair
        else
            :high_card
        end 
    end

    def straight_flush
        straight && flush
    end
    
    def poker
        NEXT_RANKS.keys.any? { |rank| cards.map(&:rank).count(rank) == 4 }
    end

    def full_house
        three_of_a_kind && pair
    end
    
    def flush
        count = 0
        (0...4).each { |idx| count += 1 if cards[idx].suit == cards[idx + 1].suit }
        count == 4
    end

    def straight
        count = 0
        (0...4).each { |idx| count += 1 if NEXT_RANKS[cards[idx].rank] == cards[idx + 1].rank }
        count += 1 if cards[0].rank == "A" && cards[1].rank == "5"
        count == 4
    end

    def three_of_a_kind
        NEXT_RANKS.keys.any? { |rank| cards.map(&:rank).count(rank) == 3 }
    end

    def two_pair
        NEXT_RANKS.keys.count { |rank| cards.map(&:rank).count(rank) == 2 } == 2
    end

    def pair
        NEXT_RANKS.keys.count { |rank| cards.map(&:rank).count(rank) == 2 } == 1
    end

    def bubble_sort_cards
        sorted = false
        until sorted
            sorted = true
            (0...4).each do |idx|
                if (@cards[idx] <=> @cards[idx+1]) == -1
                    @cards[idx], @cards[idx+1] = @cards[idx+1], @cards[idx]
                    sorted = false
                end
            end
        end
    end

end