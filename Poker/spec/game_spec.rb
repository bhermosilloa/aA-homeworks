require "game"

describe Game do

    subject(:game) { Game.new }

    describe "#initialize" do
        it "has a deck" do
            expect(game.deck).to be_a(Deck)
        end

        it "creates an empty pot" do
            expect(game.pot).to eq(0)
        end

        it "has 52 cards" do
            expect(game.deck.count).to eq(52)
        end
    end


    describe "#sit_players" do
        it "creates n given players" do
            game.sit_players(3, 100)
            expect(game.players.length).to eq(3)
        end

        it "creates valid players" do
            game.sit_players(3, 100)
            expect(game.players.first).to be_a(Player)
        end

        it "start players with given bankroll" do
            game.sit_players(3, 150)
            expect(game.players.all? { |player| player.bankroll == 150 }).to be(true)
        end
    end

    describe "#game_over?" do
        it "returns false if there are two or more players with money" do
            game.sit_players(3, 150)
            expect(game.game_over?).to be(false)
        end

        it "returns true if there is only one player with money" do
            game.sit_players(1, 450)
            game.sit_players(2, 0)
            expect(game.game_over?).to be(true)
        end
    end

    describe "#deal_players" do
        it "deals players a hand" do
            game.deal_players
            expect(game.players.all? { |player| player.hand }).to be(true)
        end

        it "players with no money get no hand" do
            game.sit_players(5, 0)
            game.sit_players(3, 100)
            game.deal_players
            expect(game.players.count { |player| player.hand }).to eq(3)
        end
    end

    describe "#add_to_the_pot" do
        it 'adds the right amount to the pot' do
            expect { game.add_to_the_pot(100) }.to change { game.pot }.by(100)
        end

        it 'returns the amount added' do
            expect(game.add_to_the_pot(100)).to eq(100)
        end
    end

    describe "#antes" do
        context "when players can pay ante" do
            before(:each) do
                game.sit_players(3, 150)
                game.sit_players(1, 0)
                game.deal_players
                game.antes
            end

            it "takes $10 from each player" do
                expect(game.players.count { |player| player.bankroll == 140 } == 3).to be(true)
            end

            it "adds antes to the pot" do
                expect(game.pot).to eq(30)
            end
        end

        context "when player doesn't complete ante" do
            before(:each) do
                game.sit_players(3, 9)
                game.deal_players
                game.antes
            end

            it "leaves player with $1" do
                expect(game.players.all? { |player| player.bankroll == 1 }).to be(true)
            end

            it "adds antes to the pot" do
                expect(game.pot).to eq(24)
            end
        end
    end

    describe "#shift" do
        it "rotates players" do
            game.sit_players(3, 150)
            player_1 = game.players.first
            game.shift
            expect(game.players.last).to be(player_1)
        end
    end

    describe "#no_more_active_players" do
        it "returns false when all but one player are folded" do
            game.sit_players(3, 150)
            game.players[0..2].each(&:fold)
            expect(game.no_more_active_players).to be(true)
        end
    end

    describe "#reset_table" do
        it "unfolds every player" do
            game.sit_players(3, 150)
            game.players.each(&:fold)
            game.players.each(&:unfold)
            expect(game.players.all?(&:folded?)).to be(false)
        end
    end

    describe "#return_cards" do
        it "all players return their cards" do
            game.sit_players(3, 150)
            game.deal_players
            game.return_cards
            expect(game.players.all? { |player| player.hand.nil? }).to be(true)
        end
    end

end