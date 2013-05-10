class GamePresenter

  attr_reader :game, :c

  def initialize(game, context)
    @game = game
    @c = context
  end

  def present
    result = '<table>'

    @game.state.board.each_with_index do |row, x|
      result << '<tr>'

      row.each_with_index do |cell, y|
        result << '<td>'
        if cell.nil?
          result << c.link_to('set this cell', c.make_move_path(x, y))
        else
          result << c.content_tag(:span, cell, class: cell)
        end
        result << '</td>'
      end
      result << '</tr>'
    end

    (result << '</table>')
  end

end
