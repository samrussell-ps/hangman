require "console_interface"
require "response"
require "guessed_letter"

class UserTalker
  attr_accessor :error

  def initialize(user_interface)
    @user_interface = user_interface
  end

  def prompt_user(prompt)
    if error
      error = nil

      @user_interface.display_output(ErrorResponse.new(prompt, error))
    else
      @user_interface.display_output(Response.new(prompt))
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
