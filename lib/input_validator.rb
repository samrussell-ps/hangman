require "./lib/game"

class InputValidator
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def convert_to_valid_form(input)
    input.upcase if valid?(input.upcase)
  end

  private

  def valid?(input)
    @user_interface.display_bad_input_alert unless is_a_single_letter?(input)
    @user_interface.display_letter_already_guessed_alert if @game.letter_has_been_guessed?(input)

    is_a_single_letter?(input) && !@game.letter_has_been_guessed?(input)
  end

  def is_a_single_letter?(input)
    !!input.match(/\A[[:alpha:]]\z/)
  end
end
