require "spec_helper"
require "game"

RSpec.describe Game do
  let(:letters_to_guess) { [] }
  let(:word_to_be_guessed) { "TELEPHONE" }
  let(:game){ Game.new(word_to_be_guessed) }

  # test direct public side effects
  before { letters_to_guess.each { |letter| game.guess_letter(letter) } }

  context "initialized with word 'TELEPHONE'" do
    let(:word_to_be_guessed) { "TELEPHONE" }

    # test direct public side effects
    describe "#guess_letter" do
      context "guessing a correct letter" do
        before do
          game.guess_letter("E")
        end

        it "doesn't decrease number of lives" do
          expect(game.lives_left).to eq(Game::INITIAL_NUMBER_OF_LIVES)
        end

        it "uncovers the letter in #masked_letters" do
          expect(game.masked_letters.include?("E")).to be_truthy
        end
      end

      context "guessing an incorrect letter" do
        before do
          game.guess_letter("A")
        end

        it "decreases number of lives" do
          expect(game.lives_left).to eq(Game::INITIAL_NUMBER_OF_LIVES - 1)
        end

        it "doesn't uncover letters in #masked_letters" do
          expect(game.masked_letters.include?("A")).to be_falsey
        end
      end

      context "guessing an incorrect letter multiple times" do
        before do
          game.guess_letter("A")
        end

        it "doesn't decreases number of lives" do
          expect(game.lives_left).to eq(Game::INITIAL_NUMBER_OF_LIVES - 1)

          game.guess_letter("A")

          expect(game.lives_left).to eq(Game::INITIAL_NUMBER_OF_LIVES - 1)
        end
      end
    end

    # test result
    describe "#lives_left" do
      subject { game.lives_left }

      context "at start of game" do
        it { is_expected.to eq(Game::INITIAL_NUMBER_OF_LIVES) }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to eq(Game::INITIAL_NUMBER_OF_LIVES) }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }

        it { is_expected.to eq(Game::INITIAL_NUMBER_OF_LIVES - 1) }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }

        it { is_expected.to eq([Game::INITIAL_NUMBER_OF_LIVES - 9, 0].max) }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }

        it { is_expected.to eq(Game::INITIAL_NUMBER_OF_LIVES) }
      end
    end
    
    # test result
    describe "#masked_letters" do
      subject { game.masked_letters }

      context "at start of game" do
        it { is_expected.to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to eq([nil, "E", nil, "E", nil, nil, nil, nil, "E"]) }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }
        
        it { is_expected.to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }

        it { is_expected.to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }
        
        it { is_expected.to eq(["T", "E", "L", "E", "P", "H", "O", "N", "E"]) }
      end
    end

    # test result
    describe "#lost?" do
      subject { game.lost? }

      context "at start of game" do
        it { is_expected.to be_falsey }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to be_falsey }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }
        
        it { is_expected.to be_falsey }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }

        it "assuming the game uses 9 lives or less" do
          expect(Game::INITIAL_NUMBER_OF_LIVES).to be >= 9
        end

        it { is_expected.to be_truthy }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }

        it { is_expected.to be_falsey }
      end
    end

    # test result
    describe "#won?" do
      subject { game.won? }

      context "at start of game" do
        it { is_expected.to be_falsey }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }
        
        it { is_expected.to be_falsey }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }

        it { is_expected.to be_falsey }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }

        it { is_expected.to be_falsey }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }

        it { is_expected.to be_truthy }
      end
    end

    # test result
    describe "#finished?" do
      subject { game.finished? }

      context "at start of game" do
        it { is_expected.to be_falsey }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to be_falsey }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }
        
        it { is_expected.to be_falsey }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }

        it { is_expected.to be_truthy }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }

        it { is_expected.to be_truthy }
      end
    end

    # test result
    describe "#letter_has_been_guessed?" do
      subject { game.letter_has_been_guessed?("A") }

      context "at start of game" do
        it { is_expected.to be_falsey }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to be_falsey }
      end

      context "after guessing 'A'" do
        let(:letters_to_guess) { ["A"] }
        
        it { is_expected.to be_truthy }
      end
    end
  end
end
