require_relative "deck"
require_relative "player"

class Game

    attr_reader :deck, :pot, :players

    def initialize
        @deck = Deck.new
        @pot = 0
        @players = []
        @player_rotation = 0
    end

    def play
        play_round until game_over?
        end_game
    end

    def play_round
        shuffle_deck
        reset_table
        deal_players
        antes
        betting_round
        change_cards
        betting_round
        end_round
        shift
    end

    def antes
        players.each { |player| add_to_the_pot(player.pay_ante(10)) unless player.hand.nil? }
    end

    def shift
        @player_rotation += 1
        players.rotate!
    end

    def no_more_active_players
        players.count { |player| !player.folded? } <= 1
    end

    def reset_table
        players.each(&:unfold)
    end

    def sit_players(num_of_players, bankroll)
        num_of_players.times { players << Player.new(bankroll) }
    end

    def game_over?
        players.count { |player| player.bankroll > 0 } <= 1
    end

    def deal_players
        players.each { |player| player.deal_hand(deck.deal_hand) if player.bankroll > 0 }
    end

    def add_to_the_pot(pot)
        @pot += pot
    end

    def return_cards
        players.each { |player| deck.return(player.return_all_cards) unless player.hand.nil? }
    end

    private

    attr_reader :player_rotation

    def betting_round
        players.each(&:reset_bet)
        leading_bet = 0
        raise_in_play = true
        leading_better = nil

        while raise_in_play
            raise_in_play = false

            players.each_with_index do |player, current_player_index|
                next if player.folded? || player.hand.nil? || player.bankroll == 0
                break if leading_better == player || no_more_active_players

                actual_player_index = (current_player_index + player_rotation)%players.length

                # Activate #timer if two or more players are actually facing each other
                # timer(actual_player_index)

                render_dealer(actual_player_index, leading_bet)

                begin
                    case player.decide
                    when :call
                        add_to_the_pot(player.call_bet(leading_bet))
                    when :fold
                        player.fold
                    when :raise
                        raise "not enough money" unless player.bankroll > leading_bet
                        bet = player.make_bet
                        raise "bet must be more than $#{leading_bet}" unless bet > leading_bet
                        raise_in_play = true
                        leading_better = player
                        leading_bet = bet
                        add_to_the_pot(player.call_bet(bet))
                    when :allin
                        bet = player.bankroll
                        if bet > leading_bet
                            raise_in_play = true
                            leading_better = player 
                            leading_bet = bet
                        end
                        add_to_the_pot(player.call_bet(bet))
                    end
                rescue => e
                    puts "#{e.message}"
                    retry
                end

            end

        end

    end

    def timer(player_index)
        system("clear")
        print "Player #{player_index + 1} in 2"
        sleep(1)
        system("clear")
        print "Player #{player_index + 1} in 1"
        sleep(1)
    end

    def render_dealer(current_player_index, leading_bet)
        player_number = current_player_index + 1
        real_player_index = (current_player_index + player_rotation)%players.length
        actual_player = players[real_player_index]
        system("clear")
        puts
        puts "Pot: $#{pot}"
        puts "Leading bet: $#{leading_bet}"
        puts
        players.each_with_index do |player, idx|
            actual_player_number = (idx + player_rotation)%players.length + 1
            if player.folded?
                puts "Player #{actual_player_number} has $#{player.bankroll} and is folded"
            else
                puts "Player #{actual_player_number} has $#{player.bankroll}"
            end
        end
        puts
        puts "Current player: #{player_number} - #{actual_player.hand} (#{actual_player.hand.hand})"
        puts
        puts "Player #{player_number} has bet: $#{actual_player.bet}" if actual_player.bet > 0
        puts "Call with $#{leading_bet - actual_player.bet}?" if leading_bet > 0
        puts if leading_bet > 0
    end

    def change_cards
        players.each_with_index do |player, current_player_index|
            break if no_more_active_players
            next if player.folded? || player.hand.nil?
            real_player_index = (current_player_index + player_rotation)%players.length + 1
            # Activate #timer if two or more players are actually facing each other
            # timer(real_player_index)
            system("clear")
            print "Player #{real_player_index}, your cards to trade: "
            puts player.hand
            begin
                cards = player.get_return_cards
            rescue => e
                puts "#{e.message}"
                retry
            end
            deck.return(cards)
            new_ones = deck.take(cards.count)
            player.change_cards(cards, new_ones)
        end
    end

    def end_round
        show_hands
        puts
        puts "WINNER"
        puts "Player #{((players.index(players.find { |player| player == winner }) + player_rotation)%players.length) + 1} has #{winner.hand} and wins $#{pot} with a #{winner.hand.hand}"
        pause_until_enter = gets.chomp
        winner.receive_pot(pot)
        @pot = 0
        return_cards
    end

    def show_hands
        system("clear")
        puts "HANDS"
        players.each_with_index do |player, index|
            actual_player = ((index + player_rotation)%players.length) + 1
            next if player.folded? || player.hand.nil?
            puts "Player #{actual_player}: #{player.hand} (#{player.hand.hand})"
        end
    end

    def winner
        players.max
    end

    def shuffle_deck
        deck.shuffle!
    end

    def end_game
        puts "The game is over"
    end

end

if __FILE__ == $PROGRAM_NAME
  poker_game = Game.new
  poker_game.sit_players(2, 500)
  poker_game.play
end