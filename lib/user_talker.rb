require "./lib/console_interface"
require "./lib/response"
require "./lib/guessed_letter"

class UserTalker
  attr_accessor :error

  def initialize(game, user_interface)
    @game = GamePresenter.new(game)
    @user_interface = user_interface
  end

  def prompt_user
    if error
      @user_interface.display_output(ErrorResponse.new(game_state_prompt, error))

      error = nil
    else
      @user_interface.display_output(Response.new(game_state_prompt))
    end
  end

  def game_finished_message
    if @game.won?
      success_status_message = "Congratulations, you won\n"
    else
      success_status_message = "Awww, you lost!\n"
    end
    @user_interface.display_output(Response.new(success_status_message + "The word was #{@game.word}"))
  end

  def data_from_user
    guessed_letter = GuessedLetter.new(@user_interface.get_input)
    if guessed_letter.valid?
      guessed_letter
    else
      nil
    end
  end

  private

  def game_state_prompt
    prompt = ""
    prompt += "The word so far: #{@game}\n"
    prompt += "You have #{@game.lives_left} lives left\n"
    prompt += "Guess a letter\n"
  end

  class GamePresenter < SimpleDelegator
    def to_s
      masked_letters.map { |letter| if letter then letter else "." end }.join
    end
  end
end
