require "./lib/game"

class InputValidator
  def initialize(game)
    @game = game
  end

  def call(input)
    if !is_a_single_letter?(input.upcase)
      :not_a_single_letter
    elsif @game.letter_already_guessed?(input.upcase)
      :letter_already_guessed
    else
      true
    end
  end

  private

  def is_a_single_letter?(input)
    !!input.match(/\A[[:alpha:]]\z/)
  end
end
