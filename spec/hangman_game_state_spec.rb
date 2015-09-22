require "hangman_game_state"

RSpec.describe HangmanGameState do

  context 'initialized with word "TELEPHONE"' do
    let(:game_state){ HangmanGameState.new('TELEPHONE') }
    describe '#lives_left' do
      it 'is 9' do
        expect(game_state.lives_left).to eq(9)
      end
    end
    describe '#masked_letters' do
      it 'is an array of nil' do
        expect(game_state.masked_letters.uniq).to match_array([nil])
      end
    end
    describe '#game_won?' do
      it 'is false' do
        expect(game_state.game_won?).to eq(false)
      end
    end
    describe '#game_lost?' do
      it 'is false' do
        expect(game_state.game_lost?).to eq(false)
      end
    end
    describe '#game_over?' do
      it 'is false' do
        expect(game_state.game_over?).to eq(false)
      end
    end

    context 'with 1 correct guess' do
      let(:letters_guessed) { ['E'] }
      before do
        letters_guessed.each {|letter| game_state.guess_letter(letter)}
      end
      describe '#lives_left' do
        it 'is 9' do
          expect(game_state.lives_left).to eq(9)
        end
      end
      describe '#masked_letters' do
        it 'is an array of a mix of nil and the letter guessed' do
          expect(game_state.masked_letters.uniq).to match_array([nil] + letters_guessed)
        end
      end
      describe '#game_won?' do
        it 'is false' do
          expect(game_state.game_won?).to eq(false)
        end
      end
      describe '#game_lost?' do
        it 'is false' do
          expect(game_state.game_lost?).to eq(false)
        end
      end
      describe '#game_over?' do
        it 'is false' do
          expect(game_state.game_over?).to eq(false)
        end
      end
    end

    context 'with 1 incorrect guess' do
      let(:letters_guessed) { ['B'] }
      before do
        letters_guessed.each {|letter| game_state.guess_letter(letter)}
      end
      describe '#lives_left' do
        it 'is 8' do
          expect(game_state.lives_left).to eq(8)
        end
      end
      describe '#masked_letters' do
        it 'is an array of nil' do
          expect(game_state.masked_letters.uniq).to match_array([nil])
        end
      end
      describe '#game_won?' do
        it 'is false' do
          expect(game_state.game_won?).to eq(false)
        end
      end
      describe '#game_lost?' do
        it 'is false' do
          expect(game_state.game_lost?).to eq(false)
        end
      end
      describe '#game_over?' do
        it 'is false' do
          expect(game_state.game_over?).to eq(false)
        end
      end
    end

    context 'with 9 incorrect guesses' do
      let(:letters_guessed) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
      before do
        letters_guessed.each {|letter| game_state.guess_letter(letter)}
      end
      describe '#lives_left' do
        it 'is 0' do
          expect(game_state.lives_left).to eq(0)
        end
      end
      describe '#masked_letters' do
        it 'is an array of nil' do
          expect(game_state.masked_letters.uniq).to match_array([nil])
        end
      end
      describe '#game_won?' do
        it 'is false' do
          expect(game_state.game_won?).to eq(false)
        end
      end
      describe '#game_lost?' do
        it 'is true' do
          expect(game_state.game_lost?).to eq(true)
        end
      end
      describe '#game_over?' do
        it 'is true' do
          expect(game_state.game_over?).to eq(true)
        end
      end
    end

    context 'with 7 correct guesses, word complete' do
      let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
      before do
        letters_guessed.each {|letter| game_state.guess_letter(letter)}
      end
      describe '#lives_left' do
        it 'is 9' do
          expect(game_state.lives_left).to eq(9)
        end
      end
      describe '#masked_letters' do
        it 'is an array of the letters guessed' do
          expect(game_state.masked_letters.uniq).to match_array(letters_guessed)
        end
      end
      describe '#game_won?' do
        it 'is true' do
          expect(game_state.game_won?).to eq(true)
        end
      end
      describe '#game_lost?' do
        it 'is false' do
          expect(game_state.game_lost?).to eq(false)
        end
      end
      describe '#game_over?' do
        it 'is true' do
          expect(game_state.game_over?).to eq(true)
        end
      end
    end
  end

end
