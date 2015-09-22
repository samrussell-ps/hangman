require 'set'

class Hangman
  def initialize(initial_word = '')
    @word_status = []
  end

  attr_reader :word_status

  def lives_left
  end

  def has_letter_been_guessed
  end

  def guess_letter(letter)
  end

  def game_won
  end

  def game_lost
  end

  def game_over
  end
end

