$:.unshift File.expand_path(File.dirname(__FILE__))

module Flip

  BOARD_SIZE = 5

  autoload :Game,   'flip/game'
  autoload :Ai,     'flip/ai'
  autoload :State,  'flip/state'
  autoload :Point,  'flip/point'

  def self.start_game
    game = Game.new

    while (!game.game_over?)
      puts "make a move, #{game.current_player}"
      coords = gets.chomp.split(',').map(&:chomp).map(&:to_i)
      game.make_move(*coords)
      # game.make_move(coords[0], coords[1])
      puts game
    end

    puts
    puts "p1: #{game.score_for(:p1)}"
    puts "p2: #{game.score_for(:p2)}"
  end

end
