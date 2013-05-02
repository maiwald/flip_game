module Flip
  class State

    def initialize
      @field = Array.new(Flip::BOARD_SIZE).map do |e|
        e = Array.new(Flip::BOARD_SIZE)
      end
    end

    def board
      @field
    end

    def make_move(player, x, y)
      if cell_empty?(x, y)
        @field[x][y] = player
        adjacent_points(x, y).each do |a, b|
          @field[a][b] = player unless cell_empty?(a, b)
        end
      end
    end

    def cell(x, y)
      @field[x][y]
    end

    def cell_empty?(x, y)
      cell(x, y).nil?
    end

    def adjacent_cells(x, y)
      adjacent_points(x, y).map { |a, b| cell(a, b) }
    end

    def adjacent_points(x, y)
      [
        [x + 1, y],
        [x - 1, y],
        [x, y + 1],
        [x, y - 1]
      ].find_all do |pair|
        pair.all? {|e| (0..Flip::BOARD_SIZE).include? e }
      end
    end

  end
end
