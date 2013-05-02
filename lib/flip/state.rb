module Flip
  class State

    attr_reader :board

    def initialize
      @board = Array.new(Flip::BOARD_SIZE).map do |e|
        e = Array.new(Flip::BOARD_SIZE)
      end
    end

    def make_move(player, point)
      if cell_empty?(point)
        set_cell(point, player)
        point.adjacent.each do |p|
          set_cell(p, player) unless cell_empty?(p)
        end
      end
    end

    def score_for(player)
      board.flatten.find_all { |e| e == player }.size
    end

    def game_over?
      board.all? { |row| row.none? { |e| e.nil? } }
    end

    def cell(point)
      board[point.x][point.y]
    end

    def set_cell(point, value)
      board[point.x][point.y] = value
    end

    def cell_empty?(point)
      cell(point).nil?
    end

  end
end
