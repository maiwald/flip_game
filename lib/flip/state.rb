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

    def successors(player)
      result = []
      (0...Flip::BOARD_SIZE).each do |x|
        (0...Flip::BOARD_SIZE).each do |y|
          point = Point.new(x, y)
          result << make_move(player, point) if cell_empty?(point)
        end
      end
      result
    end

    def ==(other)
      board == other.board
    end
  end
end
