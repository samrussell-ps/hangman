require "./lib/guessed_letter"
require "delegate"

# This class does the following:
# - Passes information to a Game
# - Retrieves information from a Game
# - Produces user output based on this information
class Controller
  def initialize(game, user_interface)
    @game = GamePresenter.new(game)
    @user_interface = user_interface
  end

  # this is almost too small to have its own class
  # but probably isn't a controller function
  def run
    # TODO: refactor this
    # pattern here is basically
    # - display prompt and any alert (no alert to begin with)
    # - get user input
    # - process user input
    # - set alert if user input is bad
    until @game.finished? do
      prompt = ""
      prompt += "The word so far: #{@game}"
      prompt += "You have #{@game.lives_left} lives left"
      prompt += "Guess a letter"

      guessed_letter = GuessedLetter.new(@user_interface.get_input)

      next unless guessed_letter.valid?

      if @game.letter_has_been_guessed?(guessed_letter.to_s)
        @user_interface.display_output("You have already guessed that letter!")
      else
        @game.guess_letter(guessed_letter.to_s)
      end
    end

    if @game.won?
      @user_interface.display_output("You won!")
    else
      @user_interface.display_output("Awww, you lost!")
    end

    @user_interface.display_output("The word was #{@game.word}")
  end

  class GamePresenter < SimpleDelegator
    def to_s
      masked_letters.map { |letter| if letter then letter else "." end }.join
    end
  end
end
