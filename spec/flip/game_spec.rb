require_relative '../../lib/flip'

module Flip
  describe Game do
    it 'is initialized with an enumerator of players' do
      expect(Game.new.players).to be_a(Enumerator)
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
      let(:state) { State.new }
      let(:game) { Game.new }

      before do
        game.stub(:state).and_return(state)
      end

      it 'makes a move as the current player' do
        state.should_receive(:make_move).with(:p1, Point.new(0, 0))
        state.should_receive(:make_move).with(:p2, Point.new(1, 1))

        game.make_move(0, 0)
        game.make_move(1, 1)
      end

      it "only makes move when point's cell is not nil" do
        game.make_move(0, 0)

        state.should_not_receive(:make_move).with(:p2, Point.new(0, 0))
        game.make_move(0, 0)
      end
    end
  end
end
