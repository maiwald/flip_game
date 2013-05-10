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

      it 'returns a new state with player assigned to the cell' do
        point = Point.new(3, 4)
        new_state = state.make_move(:foo, point)

        expect(state.cell(point)).to eql(nil)
        expect(new_state.cell(point)).to eql(:foo)
      end

      it 'assigns all filled adjacent cells to the player' do
        point = Point.new(0, 0)
        new_state = state.make_move(:foo, point).make_move(:bar, Point.new(0, 1))

        expect(new_state.cell(point)).to eql(:bar)
      end

      it 'returns self when the cell is already filled' do
        point = Point.new(0, 0)
        state.set_cell(point, :foo)

        expect(state.make_move(:foo, point)).to eql(state)
      end
    end

    describe '#score_for' do
      it 'returns the number of cells a player occupies' do
        stub_const('Flip::BOARD_SIZE', 2)
        state = State.new

        state.set_cell(Point.new(0, 0), :foo)
        state.set_cell(Point.new(0, 1), :foo)
        state.set_cell(Point.new(1, 0), :foo)
        state.set_cell(Point.new(1, 1), :bar)

        expect(state.score_for(:foo)).to eql(3)
        expect(state.score_for(:bar)).to eql(1)
        expect(state.score_for(:invalid_player)).to eql(0)
      end
    end

    describe '#game_over?' do
      it 'returns true if all cells are filled' do
        stub_const('Flip::BOARD_SIZE', 1)

        state = State.new
        expect(state.game_over?).to be_false

        state.set_cell(Point.new(0, 0), :foo)
        expect(state.game_over?).to be_true
      end
    end

    describe '#successors' do
      let(:state) { State.new }

      before do
        stub_const('Flip::BOARD_SIZE', 2)
      end

      it 'returns all possible successor states' do
        expect(state.successors(:foo)).to match_array([
          state.make_move(:foo, Point.new(0, 0)),
          state.make_move(:foo, Point.new(0, 1)),
          state.make_move(:foo, Point.new(1, 0)),
          state.make_move(:foo, Point.new(1, 1))
        ])
      end

      it 'only returns states different from the initial state' do
        state.set_cell(Point.new(0, 0), :bar)

        expect(state.successors(:foo)).to match_array([
          state.make_move(:foo, Point.new(0, 1)),
          state.make_move(:foo, Point.new(1, 0)),
          state.make_move(:foo, Point.new(1, 1))
        ])
      end
    end
  end
end
