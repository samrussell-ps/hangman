require "spec_helper"
require "game"

RSpec.describe Game do
  let(:letters_to_guess) { [] }
  let(:word_to_be_guessed) { "TELEPHONE" }
  let(:game){ Game.new(word_to_be_guessed) }
  let(:guesses_to_win) { [ "T", "E", "L", "P", "H", "O", "N" ] }
  let(:guesses_to_lose) { [ "Z", "X", "C", "V", "B", "A", "S", "D", "F" ] }
  let(:initial_lives) { 9 }

  before { letters_to_guess.each { |letter| game.guess_letter(letter) } }

  context "initialized with word 'TELEPHONE'" do
    let(:word_to_be_guessed) { "TELEPHONE" }

    describe "#guess_letter" do
      context "guessing a correct letter" do
        it "doesn't change lives_left" do
          expect{ game.guess_letter("E") }.to_not change{ game.lives_left }
        end

        it "changes #word_progress" do
          expect{ game.guess_letter("E") }.to change{ game.word_progress }
        end
      end

      context "guessing an incorrect letter" do
        it "decrements lives_left" do
          expect{ game.guess_letter("A") }.to change{ game.lives_left }.by(-1)
        end

        it "doesn't change #word_progress" do
          expect{ game.guess_letter("A") }.to_not change{ game.word_progress }
        end
      end

      context "guessing an incorrect letter multiple times" do
        before do
          game.guess_letter("A")
        end

        it "doesn't decrement number of lives" do
          expect{ game.guess_letter("A") }.to_not change{ game.lives_left }
        end
      end
    end

    describe "#lives_left" do
      subject { game.lives_left }

      context "at start of game" do
        it { is_expected.to eq(initial_lives) }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to eq(initial_lives) }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }

        it { is_expected.to eq(initial_lives - 1) }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { guesses_to_lose }

        it { is_expected.to eq(0) }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { guesses_to_win }

        it { is_expected.to eq(initial_lives) }
      end
    end
    
    describe "#word_progress" do
      subject { game.word_progress }

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
        let(:letters_to_guess) { guesses_to_lose }

        it { is_expected.to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { guesses_to_win }
        
        it { is_expected.to eq(["T", "E", "L", "E", "P", "H", "O", "N", "E"]) }
      end
    end

    describe "#lost?" do
      subject { game.lost? }

      context "at start of game" do
        it { is_expected.to be false }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to be false }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }
        
        it { is_expected.to be false }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { guesses_to_lose }

        it { is_expected.to be true }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { guesses_to_win }

        it { is_expected.to be false }
      end
    end

    describe "#won?" do
      subject { game.won? }

      context "at start of game" do
        it { is_expected.to be false }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }
        
        it { is_expected.to be false }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }

        it { is_expected.to be false }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { guesses_to_lose }

        it { is_expected.to be false }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { guesses_to_win }

        it { is_expected.to be true }
      end
    end

    describe "#finished?" do
      subject { game.finished? }

      context "at start of game" do
        it { is_expected.to be false }
      end

      context "after guessing 'E'" do
        let(:letters_to_guess) { ["E"] }

        it { is_expected.to be false }
      end

      context "after guessing 'X'" do
        let(:letters_to_guess) { ["X"] }
        
        it { is_expected.to be false }
      end

      context "after 9 bad guesses" do
        let(:letters_to_guess) { guesses_to_lose }

        it { is_expected.to be true }
      end

      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { guesses_to_win }

        it { is_expected.to be true }
      end
    end

    describe "#letter_already_guessed?" do
      context "with letter 'A'" do
        subject { game.letter_already_guessed?("A") }

        context "at start of game" do
          it { is_expected.to be false }
        end

        context "after guessing 'E'" do
          let(:letters_to_guess) { ["E"] }

          it { is_expected.to be false }
        end

        context "after guessing 'A'" do
          let(:letters_to_guess) { ["A"] }
          
          it { is_expected.to be true }
        end
      end
    end
  end
end
