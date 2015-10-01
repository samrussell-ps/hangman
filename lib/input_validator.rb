require "./lib/game"

class InputValidator
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def guess_letter_or_alert_user(input)
    if is_a_single_letter?(input.upcase) && !@game.letter_has_been_guessed?(input.upcase)
      @game.guess_letter(input.upcase)
    else
      @user_interface.display_bad_input_alert unless is_a_single_letter?(input.upcase)
      @user_interface.display_letter_already_guessed_alert if @game.letter_has_been_guessed?(input.upcase)
    end
  end

  private

  def is_a_single_letter?(input)
    !!input.match(/\A[[:alpha:]]\z/)
  end
end
