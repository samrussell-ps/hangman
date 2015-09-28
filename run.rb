require "./lib/controller"
require "./lib/game"
require "./lib/console_interface"
require "./lib/user_talker"
require "./lib/random_word_generator"

game = Game.new(RandomWordGenerator.random_word.upcase)
user_talker = UserTalker.new(game, ConsoleInterface.new)
Controller.new(game, user_talker).run
