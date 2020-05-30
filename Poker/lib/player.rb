require_relative "hand"

class Player

    attr_reader :hand
    attr_accessor :bankroll, :bet

    def initialize(bankroll=100)
        @bankroll = bankroll
        @bet = 0
    end

    def deal_hand(hand)
        @hand = hand
    end

    def decide
        puts
        print "(c)all - (f)old - (r)aise/bet - (a)all-in  >> "
        decision = gets.chomp.downcase
        case decision
        when "c" then :call
        when "f" then :fold
        when "r" then :raise
        when "a" then :allin
        else
            puts "invalid choice"
            decide
        end
    end

    def pay_ante
        if bankroll > 10
            self.bankroll -= 10
            10
        else
            bkr = bankroll
            self.bankroll = 1
            bkr - 1
        end
    end

    def make_bet
        print "(bankroll: $#{bankroll} - Enter your bet >> $"
        bet = gets.chomp.to_i
        raise "not enough money" unless bet <= bankroll
        bet
    end

    def call_bet(leading_bet)
        pending_bet = leading_bet - bet
        if bankroll <= pending_bet
            new_bet = bankroll
            self.bankroll = 0
            self.bet += new_bet
            new_bet
        else
            self.bankroll -= pending_bet
            self.bet += pending_bet
            pending_bet
        end
    end

    def unfold
        @folded = false
    end

    def fold
        @folded = true
    end

    def folded?
        @folded
    end

    def return_all_cards
        cards = @hand.cards
        @hand = nil
        cards
    end

    def receive_pot(pot)
        @bankroll += pot
    end

    def get_return_cards
        print "What cards do you want to return to dealer? (ex. 1, 2, 5) >> "
        cards = gets.chomp.split(", ").map(&:to_i)
        raise "you can't return more than three cards" unless cards.count <= 3
        puts
        cards.map { |idx| hand.cards[idx - 1] }
    end

    def reset_bet
        @bet = 0
    end

    def change_cards(trash_cards, new_cards)
        @hand.change_cards(trash_cards, new_cards)
    end

    def <=>(player2)
        return 0 if @hand.nil? && player2.hand.nil?
        return -1 if @hand.nil?
        return 1 if player2.hand.nil?
        @hand <=> player2.hand
    end

end