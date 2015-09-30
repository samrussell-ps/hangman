require "set"

class Game
  INITIAL_NUMBER_OF_LIVES = 9

  attr_reader :word

  def initialize(initial_word_in_uppercase)
    @word = initial_word_in_uppercase
    @guessed_letters = Set.new
  end

  def lives_left
    INITIAL_NUMBER_OF_LIVES - incorrect_guess_count
  end

  def word_progress
    @word.chars.map { |char| if @guessed_letters.include?(char) then char else "_" end }.join
  end

  def letter_has_been_guessed?(letter)
    @guessed_letters.include?(letter)
  end

  def guess_letter(letter)
    @guessed_letters.add(letter)
  end

  def won?
    @word.chars.all? { |char| @guessed_letters.include?(char) } 
  end

  def lost?
    lives_left == 0
  end

  def finished?
    won? || lost?
  end

  private

  def total_guess_count
    @guessed_letters.size
  end

  def correct_guess_count
    (@word.chars.uniq & @guessed_letters.to_a).size
  end

  def incorrect_guess_count
    total_guess_count - correct_guess_count
  end
end
