module Flip
  class Point < Struct.new(:x, :y)

    def adjacent
      adjacency_combinations.
        map { |c| Point.new(*c) }.
        find_all { |p| p.valid? }
    end

    def valid?
      [x, y].all? { |e| (0...Flip::BOARD_SIZE).include? e }
    end

    private

    def adjacency_combinations
      [
        [x + 1, y],
        [x - 1, y],
        [x, y + 1],
        [x, y - 1]
      ]
    end

  end
end
