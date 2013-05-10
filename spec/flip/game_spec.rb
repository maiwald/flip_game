require_relative '../../lib/flip'

module Flip
  describe Game do
    it 'is initialized with an enumerator of players' do
      expect(Game.new.players).to eql([:p1, :p2])
    end

    it 'is initialized with new state state' do
      state = stub(:state)
      State.should_receive(:new).and_return state
      expect(Game.new.state).to eql(state)
    end

    describe '#next_player' do
      it 'iterates through the players' do
        game = Game.new

        expect(game.next_player).to eql(:p1)
        expect(game.next_player).to eql(:p2)
        expect(game.next_player).to eql(:p1)
        expect(game.next_player).to eql(:p2)
      end
    end

    describe '#make_move' do
      let(:game) { Game.new }

      it 'makes a move as the next player' do
        game.should_receive(:next_player).and_return(:foo)
        game.make_move(0, 0)
        expect(game.state.cell(Point.new(0,0))).to eql(:foo)
      end

      it "only makes move when point's cell is not nil" do
        state = stub(:state, :cell_empty? => false)
        game.should_receive(:state).and_return(state)

        state.should_not_receive(:make_move)
        game.make_move(0, 0)
      end
    end

    describe '#winner/#loser' do
      it 'returns the player with the most owned cells' do
        stub_const('Flip::BOARD_SIZE', 1)
        game = Game.new

        game.make_move(0,0)

        expect(game.winner).to eql(:p1)
        expect(game.loser).to eql(:p2)
      end

      it 'returns nil if the game is not over yet' do
        game = Game.new

        expect(game.winner).to eql(nil)
        expect(game.loser).to eql(nil)
      end
    end
  end
end
