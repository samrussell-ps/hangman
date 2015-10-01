require "./lib/input_validator"

class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
    @input_validator = InputValidator.new(@game)
  end

  def run
    play_next_turn until @game.finished?

    finish_game
  end

  private

  def play_next_turn
    @user_interface.display_game_state

    user_input = @user_interface.ask_for_user_input
    case @input_validator.call(user_input)
      when true
        @game.guess_letter(user_input)
      when :not_a_single_letter
        @user_interface.display_bad_input_alert
      when :letter_already_guessed
        @user_interface.display_letter_already_guessed_alert
    end
  end

  def finish_game
    if @game.won?
      @user_interface.display_game_won_message
    else
      @user_interface.display_game_lost_message
    end
  end
end
