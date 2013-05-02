module Flip

  class State
    def initialize
      @field = Array.new(5).map do |e|
        e = Array.new(5)
      end
    end

    def board
      @field
    end

    def make_move(player, x, y)
      @field[x][y] = player if cell(x, y).nil?
    end

    def cell(x, y)
      @field[x][y]
    end

    def adjacent_cells(x, y)
    end
  end

end
