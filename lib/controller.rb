require "./lib/guessed_letter"
require "delegate"

# This class does the following:
# - Passes information to a Game
# - Retrieves information from a Game
# - Produces user output based on this information
class Controller
  def initialize(game, user_talker)
    @game = game
    @user_talker = user_talker
  end

  # this is almost too small to have its own class
  # but probably isn't a controller function
  def run
    # TODO: refactor this
    # pattern here is basically
    # - prompt user
    # - get user input
    # - update game
    # - pass game alert onto talker
    until @game.finished? do
      # should look at the alert status from last time
      # then pass the whole thing to user_interface
      # @user_interface.display_output(Response.new(prompt, alert if ...))
      @user_talker.prompt_user

      guessed_letter = @user_talker.data_from_user

      next unless guessed_letter

      if @game.letter_has_been_guessed?(guessed_letter.to_s)
        @user_talker.error = "You have already guessed that letter!"
      else
        @game.guess_letter(guessed_letter.to_s)
      end
    end

    @user_talker.game_finished_message
  end
end
