require 'set'

class Hangman
  WORDLIST_FILENAME = './data/wordsEn.txt'
  INITIAL_NUMBER_OF_LIVES = 9
  def initialize(initial_word)
    # TODO: doesn't check for non-alpha characters
    # TODO: doesn't check for non-string or 0-length string
    # TODO: doesn't enforce uppercase
    @word = initial_word
    @masked_letters = (1..@word.size).map{nil}
    @guessed_letters = Set.new
  end

  attr_reader :masked_letters

  def get_number_of_words
    File.readlines('./data/wordsEn.txt').size
  end

  def get_random_word
    File.readlines('./data/wordsEn.txt')[rand(get_number_of_words)]
  end

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

