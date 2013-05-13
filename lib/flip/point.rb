module Flip
  class Point < Struct.new(:x, :y)

    def adjacent
      adjacency_combinations.map { |c| Point.new(*c) }
    end

    private

    def adjacency_combinations
      [
        [x + 1, y],
        [x - 1, y],
        [x, y + 1],
        [x, y - 1],

        [x - 1, y - 1],
        [x + 1, y - 1],
        [x - 1, y + 1],
        [x + 1, y + 1]
      ].find_all { |arr| arr.all? { |e| (0...Flip::BOARD_SIZE).include? e } }
    end

  end
end
