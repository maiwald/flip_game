require_relative 'flip'

module Solver

  Infinity = 1.0/0.0
  NegInfinity = -1.0/0.0

  def self.solve(state, players, player, depth)
    node = Node.new(nil, state, players, player)
    result = MiniMax.max(node, [NegInfinity, nil], [Infinity, nil], depth * 2).fetch(1)

    while result.parent.state != state
      result = result.parent
    end

    result.state
  end

  class Node
    attr_reader :state, :parent

    def initialize(parent, state, players, current_player)
      @parent = parent
      @state = state
      @players = players
      @current_player = current_player

      puts "create node #{current_player}, #{rating}, #{state.inspect}"
    end

    def rating
      state.score_for(@current_player)
    end

    def children
      state.successors(@current_player).map { |s| Node.new(self, s, @players, next_player) }
    end

    def next_player
      next_index = (@players.index(@current_player) + 1) % @players.size
      @players.fetch(next_index)
    end
  end

  module MiniMax

    def self.max(node, a, b, depth)
      return [node.rating, node] if node.state.game_over? || depth.zero?

      best = [NegInfinity, nil]

      node.children.
        map { |child| [child.rating, child] }.each do |r, n|
          a = best if best[0] > a[0]

          val = min(n, a, b, depth - 1)
          best = val if val[0] > best[0]

          return best if best[0] >= b[0]
        end

      return best
    end

    def self.min(node, a, b, depth)
      return [node.rating, node] if node.state.game_over? || depth.zero?

      best = [Infinity, nil]

      node.children.
        map { |child| [child.rating, child] }.each do |r, n|
          b = best if best[0] < b[0]

          val = max(n, a, b, depth - 1)
          best = val if val[0] < best[0]

          return best if a[0] >= best[0]
        end

      return best
    end

  end

end
