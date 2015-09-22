require "hangman"

RSpec.describe Hangman do

  shared_context 'new Hangman object' do
    before do
      @hangman = Hangman.new('TELEPHONE')
    end
  end
  shared_context 'Hangman object with 1 correct guess' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['E']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
  end
  shared_context 'Hangman object with 1 incorrect guess' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['B']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
  end
  shared_context 'Hangman object with 9 incorrect guesses' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
  end
  shared_context 'Hangman object with 7 correct guesses, word complete' do
    before do
      @hangman = Hangman.new('TELEPHONE')
      @letters_guessed = ['T', 'E', 'L', 'P', 'H', 'O', 'N']
      @letters_guessed.each {|letter| @hangman.guess_letter(letter)}
    end
  end

  describe '#lives_left' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
        it 'is 9' do
          expect(@hangman.lives_left).to eq(9)
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is 9' do
          expect(@hangman.lives_left).to eq(9)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is 8' do
          expect(@hangman.lives_left).to eq(8)
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is 0' do
          expect(@hangman.lives_left).to eq(0)
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is 9' do
          expect(@hangman.lives_left).to eq(0)
        end
      end
    end
  end

  describe '#word_status' do
    context 'New Hangman object' do
      include_context 'new Hangman object' do
        it 'is an array of nils' do
          expect(@hangman.word_status).to match_array([nil])
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is an array of a mix of nil and the letter guessed' do
          expect(@hangman.word_status).to match_array([nil] + @letters_guessed)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is an array of nils' do
          expect(@hangman.word_status).to match_array([nil])
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is an array of nils' do
          expect(@hangman.word_status).to match_array([nil])
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is an array of correct guesses and no nils' do
          expect(@hangman.word_status).to match_array(@letters_guessed)
        end
      end
    end
  end

  describe '#still_alive?' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
        it 'is true' do
          expect(@hangman.still_alive?).to eq(true)
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is true' do
          expect(@hangman.still_alive?).to eq(true)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is true' do
          expect(@hangman.still_alive?).to eq(true)
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is false' do
          expect(@hangman.still_alive?).to eq(false)
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is true' do
          expect(@hangman.still_alive?).to eq(true)
        end
      end
    end
  end

  describe '#game_won?' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
        it 'is false' do
          expect(@hangman.game_won?).to eq(false)
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is false' do
          expect(@hangman.game_won?).to eq(false)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is false' do
          expect(@hangman.game_won?).to eq(false)
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is false' do
          expect(@hangman.game_won?).to eq(false)
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is true' do
          expect(@hangman.game_won?).to eq(true)
        end
      end
    end
  end

  describe '#game_lost?' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
        it 'is false' do
          expect(@hangman.game_lost?).to eq(false)
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is false' do
          expect(@hangman.game_lost?).to eq(false)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is false' do
          expect(@hangman.game_lost?).to eq(false)
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is true' do
          expect(@hangman.game_lost?).to eq(true)
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is false' do
          expect(@hangman.game_lost?).to eq(false)
        end
      end
    end
  end

  describe '#game_over?' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
        it 'is false' do
          expect(@hangman.game_over?).to eq(false)
        end
        it 'equals (game_won? || game_lost?)' do
          expect(@hangman.game_over?).to eq(@hangman.game_won || @hangman.game_lost)
        end
      end
    end
    context 'Hangman object with 1 correct guess' do
      include_context 'Hangman object with 1 correct guess' do
        it 'is false' do
          expect(@hangman.game_over?).to eq(false)
        end
        it 'equals (game_won? || game_lost?)' do
          expect(@hangman.game_over?).to eq(@hangman.game_won || @hangman.game_lost)
        end
      end
    end
    context 'Hangman object with 1 incorrect guess' do
      include_context 'Hangman object with 1 incorrect guess' do
        it 'is false' do
          expect(@hangman.game_over?).to eq(false)
        end
        it 'equals (game_won? || game_lost?)' do
          expect(@hangman.game_over?).to eq(@hangman.game_won || @hangman.game_lost)
        end
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      include_context 'Hangman object with 9 incorrect guesses' do
        it 'is true' do
          expect(@hangman.game_over?).to eq(true)
        end
        it 'equals (game_won? || game_lost?)' do
          expect(@hangman.game_over?).to eq(@hangman.game_won || @hangman.game_lost)
        end
      end
    end
    context 'Hangman object with 7 correct guesses, word complete' do
      include_context 'Hangman object with 7 correct guesses, word complete' do
        it 'is true' do
          expect(@hangman.game_over?).to eq(true)
        end
        it 'equals (game_won? || game_lost?)' do
          expect(@hangman.game_over?).to eq(@hangman.game_won || @hangman.game_lost)
        end
      end
    end
  end

  describe '#guess_letter' do
    context "new Hangman object" do
      include_context 'new Hangman object' do
      end
    end
  end

  describe '#has_letter_been_guessed' do
  end

  describe '#add_guessed_letter' do
  end

end
