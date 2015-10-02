class Guess
  attr_reader :errors

  def initialize(game, input)
    @game = game
    @input = input.upcase
    @valid = is_a_single_letter? && !@game.letter_already_guessed?(input)
    @errors = []
    @errors << :not_a_single_letter if !is_a_single_letter?
    @errors << :letter_already_guessed if @game.letter_already_guessed?(@input)
  end

  def valid?
    @valid
  end

  def submit
    @game.guess_letter(@input)
  end

  private

  def is_a_single_letter?
    [*"A".."Z"].include?(@input)
  end
end
