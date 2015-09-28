class Controller
  def initialize(game, user_talker)
    @game = game
    @user_talker = user_talker
  end

  def run
    until @game.finished? do
      @user_talker.prompt_user

      guessed_letter = @user_talker.letter_from_user

      next unless guessed_letter

      if @game.letter_has_been_guessed?(guessed_letter)
        @user_talker.error = "You have already guessed that letter!"
      else
        @game.guess_letter(guessed_letter)
      end
    end

    @user_talker.game_finished_message
  end
end
