class Guess
  attr_reader :errors

  def initialize(game, input)
    @game = game
    @uppercase_input = input.upcase

    @errors = []
    @errors << :not_a_single_letter unless is_a_single_uppercase_letter?
    @errors << :letter_already_guessed if @game.letter_already_guessed?(@uppercase_input)
  end

  def valid?
    @errors.empty?
  end

  def submit
    @game.guess_letter(@uppercase_input)
  end

  private

  def is_a_single_uppercase_letter?
    [*"A".."Z"].include?(@uppercase_input)
  end
end
