module Flip
  class State

    attr_reader :board

    def initialize(board = nil)
      @board = board || Array.new(Flip::BOARD_SIZE).map do |e|
        e = Array.new(Flip::BOARD_SIZE)
      end
    end

    def make_move(player, point)
      return self unless cell_empty?(point)

      result = State.new(@board.map { |row| row.clone })

      result.set_cell(point, player)
      point.adjacent.each do |p|
        result.set_cell(p, player) unless cell_empty?(p)
      end

      result
    end

    def rating_for(player)
      surrounded_points = points.find_all do |p|
        cell(p) == player && p.adjacent.none? { |adjacent| cell_empty?(p) }
      end.count

      score_for(player) + 3 * surrounded_points
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

    def points
      (0...Flip::BOARD_SIZE).map do |x|
        (0...Flip::BOARD_SIZE).map do |y|
          Point.new(x, y)
        end
      end.flatten
    end

    def successors(player)
      points.find_all { |p| cell_empty?(p) }.map do |point|
        make_move(player, point)
      end
    end

    def ==(other)
      board == other.board
    end
  end
end
