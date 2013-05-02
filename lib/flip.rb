$:.unshift File.expand_path(File.dirname(__FILE__))

module Flip

  BOARD_SIZE = 5

  autoload :State, 'flip/state'
  autoload :Point, 'flip/point'

end
