require 'forwardable'

module Flip
  class Game

    attr_reader :players, :state

    extend Forwardable
    def_delegators :@state, :game_over?, :score_for

    def initialize
      reset
    end

    def reset
      @players = [:p1, :p2]
      @current = 0
      @state = State.new
    end

    def make_move(x, y)
      point = Point.new(x, y)
      if state.cell_empty?(point)
        @state = state.make_move(next_player, point)
      end
    end

    def current_player
      players.fetch(@current)
    end

    def next_player
      c = @current
      @current = (@current + 1) % players.size
      players.fetch(c)
    end

    def winner
      players.max_by { |p| score_for(p) } if game_over?
    end

    def loser
      players.min_by { |p| score_for(p) } if game_over?
    end

    def to_s
      str = ""
      state.board.each do |row|
        str << row.map { |e| e.nil? ? '  ' : e }.join(", ")
        str << "\n"
      end
      str
    end
  end
end
