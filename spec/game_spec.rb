require "game"

RSpec.describe Game do
  let(:letters_to_guess) { [] }
  let(:word_to_be_guessed) { "TELEPHONE" }
  let(:game){ Game.new(word_to_be_guessed) }
  before { letters_to_guess.each { |letter| game.guess_letter(letter) } }


  context "initialized with word \"TELEPHONE\"" do
    let(:word_to_be_guessed) { "TELEPHONE" }

    describe "#lives_left" do
      subject { game.lives_left }
      context "at start of game" do
        it { is_expected.to be 9 }
      end
      context "after guessing \"E\"" do
        let(:letters_to_guess) { ["E"] }
        it { is_expected.to be 9 }
      end
      context "after guessing \"X\"" do
        let(:letters_to_guess) { ["X"] }
        it { is_expected.to be 8 }
      end
      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }
        it { is_expected.to be 0 }
      end
      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }
        it { is_expected.to be 9 }
      end
    end

    describe "#masked_letters" do
      subject { game.masked_letters }
      context "at start of game" do
        it { is_expected.to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      end
      context "after guessing \"E\"" do
        let(:letters_to_guess) { ["E"] }
        it { is_expected.to eq([nil, "E", nil, "E", nil, nil, nil, nil, "E"]) }
      end
      context "after guessing \"X\"" do
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

    describe "#lost?" do
      subject { game.lost? }
      context "at start of game" do
        it { is_expected.to be_falsey }
      end
      context "after guessing \"E\"" do
        let(:letters_to_guess) { ["E"] }
        it { is_expected.to be_falsey }
      end
      context "after guessing \"X\"" do
        let(:letters_to_guess) { ["X"] }
        it { is_expected.to be_falsey }
      end
      context "after 9 bad guesses" do
        let(:letters_to_guess) { ["A", "B", "D", "F", "S", "W", "X", "Y", "Z"] }
        it { is_expected.to be_truthy }
      end
      context "after guessing the word, no bad guesses" do
        let(:letters_to_guess) { ["T", "E", "L", "P", "H", "O", "N"] }
        it { is_expected.to be_falsey }
      end
    end

    describe "#won?" do
      subject { game.won? }
      context "at start of game" do
        it { is_expected.to be_falsey }
      end
      context "after guessing \"E\"" do
        let(:letters_to_guess) { ["E"] }
        it { is_expected.to be_falsey }
      end
      context "after guessing \"X\"" do
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

    describe "#finished?" do
      subject { game.finished? }
      context "at start of game" do
        it { is_expected.to be_falsey }
      end
      context "after guessing \"E\"" do
        let(:letters_to_guess) { ["E"] }
        it { is_expected.to be_falsey }
      end
      context "after guessing \"X\"" do
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
  end

end
