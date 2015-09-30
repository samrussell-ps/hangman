require "./lib/controller"
require "./lib/game"
require "./lib/user_interface"
require "./lib/random_word_generator"

game = Game.new(RandomWordGenerator.random_word.upcase)

user_interface = UserInterface.new(game)

Controller.new(game, user_interface).run
