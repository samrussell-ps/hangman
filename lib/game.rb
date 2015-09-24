require "set"

# This class holds the game state for a game of hangman
# It can be initialised with a word in uppercase characters
# It can answer abstract questions about the game:
# - have we won
# - have we lost
# - is the game over
# - has a letter been guessed
# - how many lives are left
# The game state can be changed by guessing a letter
class Game
  INITIAL_NUMBER_OF_LIVES = 9

  attr_reader :word

  def initialize(initial_word_in_uppercase)
    @word = initial_word_in_uppercase
    @guessed_letters = Set.new
  end

  def lives_left
    # TODO: should call correct_guess_count
    INITIAL_NUMBER_OF_LIVES - @guessed_letters.size + (masked_letters.uniq - [nil]).size
  end

  def masked_letters
    # returns an array showing the word with un-guessed letters replaced with nil
    @word.chars.map { |char| if @guessed_letters.include?(char) then char else nil end }
  end

  def letter_has_been_guessed?(letter)
    @guessed_letters.include?(letter)
  end

  def guess_letter(letter)
    @guessed_letters.add(letter)
  end

  def won?
    !masked_letters.include?(nil)
  end

  def lost?
    lives_left == 0
  end

  def finished?
    won? || lost?
  end

  private
  
  # TODO: test this
  def correct_guess_count
  end
end

