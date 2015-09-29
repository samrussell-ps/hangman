require "./lib/console_interface"
require "./lib/response"
require "./lib/guessed_letter"

class UserTalker
  attr_accessor :alert

  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  # command
  def prompt_user
    if alert
      @user_interface.display_output(GameContinueWithAlertResponse.new(@game, alert))

      alert = nil
    else
      @user_interface.display_output(GameContinueResponse.new(@game))
    end
  end

  # command
  def game_finished_message
    if @game.won?
      @user_interface.display_output(GameFinishedWonResponse.new(@game))
    else
      @user_interface.display_output(GameFinishedLostResponse.new(@game))
    end
  end

  # query
  def letter_from_user
    guessed_letter = GuessedLetter.new(@user_interface.get_input)

    if guessed_letter.valid?
      guessed_letter.to_s
    else
      nil
    end
  end
end
