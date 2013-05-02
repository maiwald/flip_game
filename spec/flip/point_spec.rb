require_relative '../../lib/flip'

module Flip
  describe Point do
    it 'takes two coordinates' do
      Point.new(0, 0)
    end

    describe '#adjacent' do
      it 'returns all adjecent points' do
        stub_const('Flip::BOARD_SIZE', 3)
        point = Point.new(1, 1)

        expect(point.adjacent).to match_array(
          [[0, 1], [2, 1], [1, 0], [1, 2]].map do |coordinates|
            Point.new(*coordinates)
          end
        )
      end

      it 'only returns points inside the boundaries' do
        stub_const('Flip::BOARD_SIZE', 3)
        point = Point.new(0, 0)

        expect(point.adjacent).to match_array(
          [[0, 1], [1, 0]].map do |coordinates|
            Point.new(*coordinates)
          end
        )
      end

      it 'returns all adjecent points' do
        stub_const('Flip::BOARD_SIZE', 1)
        point = Point.new(0, 0)

        expect(point.adjacent).to eql([])
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
  end
end
