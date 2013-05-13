require_relative '../solver'

module Flip
  module Ai
    def make_cpu_move
      unless game_over?
        @state = Solver.solve(@state, players, next_player, 2)
      end
    end
  end
end