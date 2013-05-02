require_relative '../../lib/flip'

module Flip
  describe State do

    it 'should initialize with an empty 5x5 matrix' do
      board = State.new.board

      expect(board).to have(5).entries
      board.each do |row|
        expect(row).to have(5).entries
      end
    end

    describe '#make_move' do
      let(:state) { State.new }

      it 'assigns a player to a cell' do
        point = Point.new(3, 4)
        state.make_move(:foo, point)

        expect(state.cell(point)).to eql(:foo)
      end

      it 'only assigns empty cells' do
        point = Point.new(3, 4)
        state.make_move(:foo, point)
        state.make_move(:bar, point)

        expect(state.cell(point)).to eql(:foo)
      end

      it 'assigns all filled adjacent cells to the player' do
        point = Point.new(0, 0)
        state.make_move(:foo, point)
        state.make_move(:bar, Point.new(0, 1))

        expect(state.cell(point)).to eql(:bar)
      end
    end

    describe '#game_over?' do
      it 'returns true if all cells are filled' do
        stub_const('Flip::BOARD_SIZE', 1)

        state = State.new
        expect(state.game_over?).to be_false

        state.make_move(:foo, Point.new(0, 0))
        expect(state.game_over?).to be_true
      end
    end
  end
end
