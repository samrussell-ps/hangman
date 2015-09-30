require "./lib/input_validator"

class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  # command
  def run
    until @game.finished? do
      @user_interface.display_game_state

      user_input = @user_interface.user_input

      if InputValidator.valid?(user_input)
        if @game.letter_has_been_guessed?(user_input.upcase)
          @user_interface.display_alert("Letter has already been guessed")
        else
          @game.guess_letter(user_input.upcase)
        end
      else
        @user_interface.display_alert("Invalid data")
      end
    end

    if @game.won?
      @user_interface.display_game_won_message
    else
      @user_interface.display_game_lost_message
    end
  end
end
