require "./lib/guessed_letter"

class Controller
  def initialize(game, user_talker)
    @game = game
    @user_talker = user_talker
  end

  def run
    until @game.finished? do
      @user_talker.prompt_user

      guessed_letter = @user_talker.data_from_user

      next unless guessed_letter

      if @game.letter_has_been_guessed?(guessed_letter.to_s)
        @user_talker.error = "You have already guessed that letter!"
      else
        @game.guess_letter(guessed_letter.to_s)
      end
    end

    @user_talker.game_finished_message
  end
end
