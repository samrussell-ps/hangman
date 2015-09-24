# This class does the following:
# - Initialises a Game (not anymore!)
# - Validates user input (maybe should be done somewhere else?)
# - Passes information to a Game
# - Retrieves information from a Game
# - Produces user output based on this information
class Controller
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def valid_input?(input)
    input != nil && input.match(/\A[[:alpha:]]+\z/) && input.size == 1
  end

  def prepare_input(input)
    if valid_input?(input)
      input.upcase
    else
      nil
    end
  end

  def masked_word
    @game.masked_letters.map { |letter| if letter then letter else "." end }.join
  end

  def run
    until @game.finished? do
      @user_interface.display_output("The word so far: #{masked_word}")
      @user_interface.display_output("You have #{@game.lives_left} lives left")
      @user_interface.display_output("Guess a letter")

      input = @user_interface.get_input

      if valid_input?(input)
        guessed_letter = prepare_input(input)

        if @game.letter_has_been_guessed?(guessed_letter)
          @user_interface.display_output("You have already guessed that letter!")
        else
          @game.guess_letter(guessed_letter)
        end
      end
    end

    if @game.won?
      @user_interface.display_output("You won!")
    else
      @user_interface.display_output("Awww, you lost!")
    end

    @user_interface.display_output("The word was #{@game.word}")
  end
end
