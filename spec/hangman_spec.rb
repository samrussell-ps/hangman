require "hangman"

RSpec.describe Hangman do
  describe '#lives_left' do
    context 'New Hangman object with random word' do
      before do
        @hangman = Hangman.new()
      end
      it 'returns 9 lives left' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
  end

  # stuff below here needs refactoring
  describe '#still_alive?' do
    context 'New hangman object with random word' do
      before do
        @hangman = Hangman.new()
      end
      it 'says whether we are still alive' do
        expect(@hangman.still_alive).to be true
      end
    end
  end
  describe '#has_letter_been_guessed' do
    context 'New hangman object with random word' do
      before do
        @hangman = Hangman.new()
      end
      it 'checks whether we have guessed this letter' do
        # valid data
        expect(@hangman.has_letter_been_guessed('A')).to eq(false)
        expect(@hangman.has_letter_been_guessed('E')).to eq(false)
        expect(@hangman.has_letter_been_guessed('U')).to eq(false)
        expect(@hangman.has_letter_been_guessed('Z')).to eq(false)
        # weird data
        expect(@hangman.has_letter_been_guessed('#')).to eq(false)
        expect(@hangman.has_letter_been_guessed('&')).to eq(false)
        expect(@hangman.has_letter_been_guessed('!')).to eq(false)
        expect(@hangman.has_letter_been_guessed(')')).to eq(false)
      end
    end
  end

  context 'New Hangman object with word == "INSECT", about to guess letter' do
    # haven't done "before" here as we guess correct and incorrect
    # want to test lives_left with a correct guess and incorrect guess
    # so we need two different instances
    # I don't think this should be done in two different contexts
    describe '#guess_letter' do
      it 'guesses a letter, loses points if not correct' do
        @hangman = Handman.new("INSECT")
        @hangman.guess_letter('I')
        expect(@hangman.has_letter_been_guessed('I')).to eq(true)
        #expect(@hangman.
      end
    end
  end

  context 'New Hangman object with word == "INSECT", guessed "I"' do
    before do
      @hangman = Hangman.new('INSECT')
      @hangman.guess_letter('I')
    end
    describe '#has_letter_been_guessed?' do
      it 'Returns true for "I", false for others' do
        expect(@hangman.has_letter_been_guessed('A')).to eq(false)
        expect(@hangman.has_letter_been_guessed('Z')).to eq(false)
        expect(@hangman.has_letter_been_guessed('G')).to eq(false)
        expect(@hangman.has_letter_been_guessed('I')).to eq(true)
      end
    end
  end
end
