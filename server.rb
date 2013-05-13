require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'lib/flip'
require_relative 'lib/solver'
require_relative 'presenters/game_presenter'

if development?
  also_reload File.join(File.dirname(__FILE__), 'presenters')
  also_reload File.join(File.dirname(__FILE__), 'lib/flip')
end

GAME = Flip::AiGame.new

get '/' do
  game_presenter = GamePresenter.new(GAME, self)
  haml :index, format: :html5, locals: {
    game: GAME,
    game_presenter: game_presenter
  }
end

get '/make_move' do
  GAME.make_move(params[:x].to_i, params[:y].to_i)
  redirect to('/')
end

get '/make_cpu_move' do
  GAME.make_cpu_move if GAME.respond_to?(:make_cpu_move)
  redirect to('/')
end

get '/reset' do
  GAME.reset
  redirect to('/')
end

get '/stylesheet.css' do
  sass :stylesheet, style: :compressed
end

helpers do

  def link_to(title, target)
    replace_quotes("<a href='#{target}'>#{title}</a>")
  end

  def content_tag(tag, content, attributes = {})
    "<#{tag.to_s} #{strigify_attributes(attributes)}>#{content}</#{tag.to_s}>"
  end

  def make_move_path(x, y)
    url('/make_move') << "?x=#{x}&y=#{y}"
  end

  private

  def strigify_attributes(attributes)
    replace_quotes(attributes.map { |k,v| "#{k}='#{v}'" }.join(' '))
  end

  def replace_quotes(s)
    s.gsub(/'/, '"')
  end

end
