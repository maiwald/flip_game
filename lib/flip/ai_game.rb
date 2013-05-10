require_relative '../solver'

module Flip
  class AiGame < Game
    def make_move(x, y)
      super(x, y)

      unless game_over?
        next_state = Solver.solve(@state, players, next_player, 2)
        @state = next_state
      end
    end
  end
end
