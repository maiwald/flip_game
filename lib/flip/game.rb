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
      @players = [:p1, :p2].cycle
      @state = State.new
    end

    def make_move(x, y)
      point = Point.new(x, y)
      unless state.cell(point)
        state.make_move(next_player, point)
      end
    end

    def current_player
      players.peek
    end

    def next_player
      players.next
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
