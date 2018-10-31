require 'gosu'
require_relative 'window.rb'
require_relative 'states/gameState.rb'
require_relative 'states/menuState.rb'
require_relative 'states/playState.rb'
require_relative 'states/winState.rb'

$window = Window.new
GameState.set MenuState.new
$window.show
