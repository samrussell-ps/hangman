require 'set'

# This class holds the game state for a game of hangman
# It can be initialised with a word in uppercase characters
# It can answer abstract questions about the game:
# - have we won
# - have we lost
# - is the game over
# - has a letter been guessed
# - how many lives are left
# The game state can be changed by guessing a letter
class HangmanGameState
  INITIAL_NUMBER_OF_LIVES = 9
  def initialize(initial_word_in_uppercase)
    @word = initial_word_in_uppercase
    @masked_letters = (1..@word.size).map{nil}
    @guessed_letters = Set.new
  end

  attr_reader :masked_letters

  def lives_left
    return INITIAL_NUMBER_OF_LIVES - @guessed_letters.size + (@masked_letters.uniq - [nil]).size
  end

  def has_letter_been_guessed?
  end

  def guess_letter(letter)
    @guessed_letters.add(letter)
    if @word.include?(letter)
      @guessed_letters.add(letter)
      @word.split('').each_with_index do |val, index|
        if val == letter
          @masked_letters[index] = letter
        end
      end
    end
  end

  def game_won?
    !@masked_letters.include?(nil)
  end

  def game_lost?
    lives_left == 0
  end

  def game_over?
    game_won? || game_lost?
  end
end

