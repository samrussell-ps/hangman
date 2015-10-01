require "./lib/input_validator"

class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
    @input_validator = InputValidator.new(@game, @user_interface)
  end

  def run
    play_next_turn until @game.finished?

    finish_game
  end

  private

  def play_next_turn
    @user_interface.display_game_state

    user_input = @user_interface.ask_for_user_input
    @input_validator.guess_letter_or_alert_user(user_input)
  end

  def finish_game
    if @game.won?
      @user_interface.display_game_won_message
    else
      @user_interface.display_game_lost_message
    end
  end
end
