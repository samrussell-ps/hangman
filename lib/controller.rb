require "./lib/response"

class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  # command
  def run
    alert = nil

    until @game.finished? do
      if alert
        response = Response.new(:continue_with_alert, alert + "test")
        @user_interface.display_output(response)

        alert = nil
      else
        response = Response.new(:continue, "test")
        @user_interface.display_output(response)
      end

      guessed_letter = GuessedLetter.new(@user_interface.get_input)

      next unless guessed_letter.valid?

      if @game.letter_has_been_guessed?(guessed_letter.to_s)
        alert = "You have already guessed that letter!\n"
      else
        @game.guess_letter(guessed_letter.to_s)
      end
    end

    #@user_talker.game_finished_message
  end
end
