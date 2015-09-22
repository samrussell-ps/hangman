require 'set'

class Hangman
  def initialize(initial_word = '')
    @word_status = []
  end

  attr_reader :word_status

  def run()
  end

  def lives_left()
  end

  def still_alive()
  end

  def has_letter_been_guessed()
  end

  def guess_letter(letter)
  end
end

hangman = Hangman.new()
hangman.run()
