require "player"

describe Player do
    
    subject(:player) { Player.new(100) }

    describe "#deal_hand" do
        let(:hand) { double("hand") }

        it "receives a dealed hand" do
            player.deal_hand(hand)
            expect(player.hand).to eq(hand)
        end
    end

    describe "#call_bet" do
        it "bankroll decreases by pending bet amount" do
            player.call_bet(10)
            expect { player.call_bet(20) }.to change { player.bankroll }.by(-10)
        end

        it "refreshes player's total bet" do
            player.call_bet(10)
            player.call_bet(20)
            expect(player.bet).to eq(20)
        end

        it "returns made bet" do
            expect(player.call_bet(30)).to eq(30)
        end
    end

    describe "#receive_pot" do
        it "increments player's bankroll by player's pot" do
            expect { player.receive_pot(100) }.to change { player.bankroll }.by(100)
        end
    end

    describe "#return_cards" do
        let(:hand) { double("hand") }
        let(:cards) { double("cards") }

        before(:each) do
            player.deal_hand(hand)
            allow(hand).to receive(:cards).and_return(cards)
        end

        it "returns player's cards" do
            expect(player.return_all_cards).to eq(cards)
        end

        it "leaves player with nil hand" do
            player.return_all_cards
            expect(player.hand).to be(nil)
        end
    end

end