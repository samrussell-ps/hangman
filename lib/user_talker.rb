require "./lib/console_interface"
require "./lib/response"
require "./lib/guessed_letter"
require "delegate"

class UserTalker
  attr_accessor :error

  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def prompt_user
    if error
      @user_interface.display_output(GameContinueWithAlertResponse.new(@game, error))

      error = nil
    else
      @user_interface.display_output(GameContinueResponse.new(@game))
    end
  end

  def game_finished_message
    if @game.won?
      @user_interface.display_output(GameFinishedWonResponse.new(@game))
    else
      @user_interface.display_output(GameFinishedLostResponse.new(@game))
    end
  end

  def data_from_user
    guessed_letter = GuessedLetter.new(@user_interface.get_input)

    if guessed_letter.valid?
      guessed_letter
    else
      nil
    end
  end
end
