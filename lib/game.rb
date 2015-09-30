require "set"

class Game
  INITIAL_NUMBER_OF_LIVES = 9

  attr_reader :word

  def initialize(initial_word_in_uppercase)
    @word = initial_word_in_uppercase
    @guessed_letters = Set.new
  end

  # query
  def lives_left
    INITIAL_NUMBER_OF_LIVES - incorrect_guess_count
  end

  # query
  def word_progress_string
    word_progress.map { | char | if char then char else "_" end }.join
  end

  # query
  def letter_has_been_guessed?(letter)
    @guessed_letters.include?(letter)
  end

  # command
  def guess_letter(letter)
    @guessed_letters.add(letter)
  end

  # query
  def won?
    !word_progress.include?(nil)
  end

  # query
  def lost?
    lives_left == 0
  end

  # query
  def finished?
    won? || lost?
  end

  private

  # query
  def word_progress
    # returns an array showing the word with un-guessed letters replaced with nil
    @word.chars.map { |char| if @guessed_letters.include?(char) then char else nil end }
  end

  def total_guess_count
    @guessed_letters.size
  end

  def correct_guess_count
    (word_progress.uniq - [nil]).size
  end

  def incorrect_guess_count
    total_guess_count - correct_guess_count
  end
end
