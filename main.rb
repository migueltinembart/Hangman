require_relative 'lib/game'
require_relative 'lib/player'

game = Game.new('words.txt')
game.initialize_game
game.play_game