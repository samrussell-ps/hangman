require "./lib/guess"

class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def run
    play_next_turn until @game.finished?

    finish_game
  end

  private

  def play_next_turn
    @user_interface.display_game_state

    guess = Guess.new(@game, @user_interface.ask_for_user_input)
    
    if guess.valid?
      guess.submit
    else
      alert_on_errors(guess.errors)
    end
  end

  def alert_on_errors(errors)
    errors.each do |error|
      case error
      when :not_a_single_letter
        @user_interface.display_bad_input_alert
      when :letter_already_guessed
        @user_interface.display_letter_already_guessed_alert
      end
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
