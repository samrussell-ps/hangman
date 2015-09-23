require "./lib/controller"
require "./lib/game"
require "./lib/console_interface"
require "./lib/random_word_generator"

Controller.new(Game.new(RandomWordGenerator.random_word.upcase), ConsoleInterface.new).run
