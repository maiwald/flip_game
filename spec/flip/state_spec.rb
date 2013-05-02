require_relative '../../lib/flip/state'

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
        state.make_move(:foo, 3, 4)

        expect(state.cell(3, 4)).to eql(:foo)
      end

      it 'only assigns empty cells' do
        state.make_move(:foo, 3, 4)
        state.make_move(:bar, 3, 4)

        expect(state.cell(3, 4)).to eql(:foo)
      end

      it 'assigns all filled adjacent cells to the player' do
        state.make_move(:foo, 0, 0)
        state.make_move(:bar, 0, 1)

        expect(state.cell(0, 0)).to eql(:bar)
      end
    end

    describe '#adjacent_cells' do
      let(:state) { State.new }
      it 'returns all adjecent cells' do
        state.make_move(:foo, 1, 1)
        state.make_move(:bla, 3, 1)
        state.make_move(:bar, 2, 0)
        state.make_move(:baz, 2, 2)

        expect(state.adjacent_cells(2, 1)).to match_array([:foo, :bar, :baz, :bla])
      end

      it 'only returns cells inside the boundaries' do
        state.make_move(:foo, 0, 1)
        state.make_move(:bar, 1, 0)

        expect(state.adjacent_cells(0, 0)).to match_array([:foo, :bar])
      end
    end

  end
end
