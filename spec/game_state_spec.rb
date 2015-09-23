require "game_state"

RSpec.describe GameState do
  let(:letters_to_guess) { [] }
  let(:word_to_be_guessed) { 'TELEPHONE' }
  let(:game_state){ GameState.new(word_to_be_guessed) }
  before { letters_to_guess.each { |letter| game_state.guess_letter(letter) } }


  context 'initialized with word "TELEPHONE"' do
    let(:word_to_be_guessed) { 'TELEPHONE' }

    describe '#lives_left' do
      subject { game_state.lives_left }
      context 'at start of game' do
        it { is_expected.to be 9 }
      end
      context 'after guessing "E"' do
        let(:letters_to_guess) { ['E'] }
        it { is_expected.to be 9 }
      end
      context 'after guessing "X"' do
        let(:letters_to_guess) { ['X'] }
        it { is_expected.to be 8 }
      end
      context 'after 9 bad guesses' do
        let(:letters_to_guess) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
        it { is_expected.to be 0 }
      end
      context 'after guessing the word, no bad guesses' do
        let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
        it { is_expected.to be 9 }
      end
    end

    describe '#masked_letters' do
      subject { game_state.masked_letters }
      context 'at start of game' do
        # 9 characters in TELEPHONE, so 9 blanks
        # [nil]*9 == [nil]*'TELEPHONE'.size
        it { is_expected.to be [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
      end
      context 'after guessing "E"' do
        let(:letters_to_guess) { ['E'] }
        it { is_expected.to be [nil, 'E', nil, 'E', nil, nil, nil, nil, 'E'] }
      end
      context 'after guessing "X"' do
        let(:letters_to_guess) { ['X'] }
        it { is_expected.to be [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
      end
      context 'after 9 bad guesses' do
        let(:letters_to_guess) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
        it { is_expected.to be [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
      end
      context 'after guessing the word, no bad guesses' do
        let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
        it { is_expected.to be ['T', 'E', 'L', 'E', 'P', 'H', 'O', 'N', 'E'] }
      end
    end

    describe '#lost?' do
      subject { game_state.lost? }
      context 'at start of game' do
        it { is_expected.to be_false }
      end
      context 'after guessing "E"' do
        let(:letters_to_guess) { ['E'] }
        it { is_expected.to be_false }
      end
      context 'after guessing "X"' do
        let(:letters_to_guess) { ['X'] }
        it { is_expected.to be_false }
      end
      context 'after 9 bad guesses' do
        let(:letters_to_guess) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
        it { is_expected.to be_true }
      end
      context 'after guessing the word, no bad guesses' do
        let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
        it { is_expected.to be_false }
      end
    end

    describe '#won?' do
      subject { game_state.won? }
      context 'at start of game' do
        it { is_expected.to be_false }
      end
      context 'after guessing "E"' do
        let(:letters_to_guess) { ['E'] }
        it { is_expected.to be_false }
      end
      context 'after guessing "X"' do
        let(:letters_to_guess) { ['X'] }
        it { is_expected.to be_false }
      end
      context 'after 9 bad guesses' do
        let(:letters_to_guess) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
        it { is_expected.to be_false }
      end
      context 'after guessing the word, no bad guesses' do
        let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
        it { is_expected.to be_true }
      end
    end

    describe '#finished?' do
      subject { game_state.finished? }
      context 'at start of game' do
        it { is_expected.to be_false }
      end
      context 'after guessing "E"' do
        let(:letters_to_guess) { ['E'] }
        it { is_expected.to be_false }
      end
      context 'after guessing "X"' do
        let(:letters_to_guess) { ['X'] }
        it { is_expected.to be_false }
      end
      context 'after 9 bad guesses' do
        let(:letters_to_guess) { ['A', 'B', 'D', 'F', 'S', 'W', 'X', 'Y', 'Z'] }
        it { is_expected.to be_true }
      end
      context 'after guessing the word, no bad guesses' do
        let(:letters_guessed) { ['T', 'E', 'L', 'P', 'H', 'O', 'N'] }
        it { is_expected.to be_true }
      end
    end

    describe 'THIS NEEDS REFACTORING' do
      it 'IGNORE THIS' do
        puts "\n"*10
      end
    end
  end

end
