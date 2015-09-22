require "hangman"

RSpec.describe Hangman do

  context 'new Hangman object' do
    before do
      @hangman = Hangman.new('TELEPHONE')
    end
    describe '#lives_left' do
      it 'is 9' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
    describe '#masked_letters' do
      it 'is an array of nil' do
        expect(@hangman.masked_letters.uniq).to match_array([nil])
      end
    end
    describe '#game_won?' do
      it 'is false' do
        expect(@hangman.game_won?).to eq(false)
      end
    end
    describe '#game_lost?' do
      it 'is false' do
        expect(@hangman.game_lost?).to eq(false)
      end
    end
    describe '#game_over?' do
      it 'is false' do
        expect(@hangman.game_over?).to eq(false)
      end
    end
  end

  context 'Hangman object with 1 correct guess' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['E']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
    describe '#lives_left' do
      it 'is 9' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
    describe '#masked_letters' do
      it 'is an array of a mix of nil and the letter guessed' do
        expect(@hangman.masked_letters.uniq).to match_array([nil] + @letters_guessed)
      end
    end
    describe '#game_won?' do
      it 'is false' do
        expect(@hangman.game_won?).to eq(false)
      end
    end
    describe '#game_lost?' do
      it 'is false' do
        expect(@hangman.game_lost?).to eq(false)
      end
    end
    describe '#game_over?' do
      it 'is false' do
        expect(@hangman.game_over?).to eq(false)
      end
    end
  end

  context 'Hangman object with 1 incorrect guess' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['B']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
    describe '#lives_left' do
      it 'is 8' do
        expect(@hangman.lives_left).to eq(8)
      end
    end
    describe '#masked_letters' do
      it 'is an array of nil' do
        expect(@hangman.masked_letters.uniq).to match_array([nil])
      end
    end
    describe '#game_won?' do
      it 'is false' do
        expect(@hangman.game_won?).to eq(false)
      end
    end
    describe '#game_lost?' do
      it 'is false' do
        expect(@hangman.game_lost?).to eq(false)
      end
    end
    describe '#game_over?' do
      it 'is false' do
        expect(@hangman.game_over?).to eq(false)
      end
    end
  end

  context 'Hangman object with 9 incorrect guesses' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
    describe '#lives_left' do
      it 'is 0' do
        expect(@hangman.lives_left).to eq(0)
      end
    end
    describe '#masked_letters' do
      it 'is an array of nil' do
        expect(@hangman.masked_letters.uniq).to match_array([nil])
      end
    end
    describe '#game_won?' do
      it 'is false' do
        expect(@hangman.game_won?).to eq(false)
      end
    end
    describe '#game_lost?' do
      it 'is true' do
        expect(@hangman.game_lost?).to eq(true)
      end
    end
    describe '#game_over?' do
      it 'is true' do
        expect(@hangman.game_over?).to eq(true)
      end
    end
  end

  context 'Hangman object with 7 correct guesses, word complete' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['T', 'E', 'L', 'P', 'H', 'O', 'N']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
    describe '#lives_left' do
      it 'is 9' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
    describe '#masked_letters' do
      it 'is an array of the letters guessed' do
        expect(@hangman.masked_letters.uniq).to match_array(@letters_guessed)
      end
    end
    describe '#game_won?' do
      it 'is true' do
        expect(@hangman.game_won?).to eq(true)
      end
    end
    describe '#game_lost?' do
      it 'is false' do
        expect(@hangman.game_lost?).to eq(false)
      end
    end
    describe '#game_over?' do
      it 'is true' do
        expect(@hangman.game_over?).to eq(true)
      end
    end
  end

end
