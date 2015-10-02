require "game"
require "guess"

RSpec.describe Guess do
  let(:game) { instance_double("Game") }
  let(:valid_inputs) { ["A", "a", "Z", "z", "E", "e"] }
  let(:invalid_inputs) { ["AB", "2", "\\", "" ] }

  let(:valid_guesses) do
    valid_inputs.map { |valid_input| Guess.new(game, valid_input) }
  end

  let(:invalid_guesses) do
    invalid_inputs.map { |invalid_input| Guess.new(game, invalid_input) }
  end

  let(:inputs_to_guesses) do
    (valid_inputs + invalid_inputs).each_with_object({}) do |input, output_hash|
      output_hash[input] = Guess.new(game, input)
    end
  end

  describe "#valid?" do
    before do
      allow(game).to receive(:letter_already_guessed?).and_return(false)
    end

    context "when letter hasn't been guessed" do
      it "is true for valid input" do
        valid_guesses.each { |valid_guess| expect(valid_guess.valid?).to be true }
      end

      it "is false for invalid input" do
        invalid_guesses.each { |invalid_guess| expect(invalid_guess.valid?).to be false }
      end
    end

    context "when letter has been guessed" do
    before do
      allow(game).to receive(:letter_already_guessed?).and_return(true)
    end

      it "is true for valid input" do
        valid_guesses.each { |valid_guess| expect(valid_guess.valid?).to be false }
      end

      it "is false for invalid input" do
        invalid_guesses.each { |invalid_guess| expect(invalid_guess.valid?).to be false }
      end
    end
  end

  describe "#errors" do
    before do
      allow(game).to receive(:letter_already_guessed?).and_return(false)
    end

    context "when letter hasn't been guessed" do
      it "is empty for valid input" do
        valid_guesses.each { |valid_guess| expect(valid_guess.errors).to contain_exactly() }
      end

      it "has :not_a_single_letter for invalid input" do
        invalid_guesses.each { |invalid_guess| expect(invalid_guess.errors).to contain_exactly(:not_a_single_letter) }
      end
    end

    context "when letter has been guessed" do
    before do
      allow(game).to receive(:letter_already_guessed?).and_return(true)
    end

      it "has :letter_already_guessed for valid input" do
        valid_guesses.each { |valid_guess| expect(valid_guess.errors).to contain_exactly(:letter_already_guessed) }
      end

      it "has :not_a_single_letter and :letter_already_guessed for invalid input" do
        invalid_guesses.each { |invalid_guess| expect(invalid_guess.errors).to contain_exactly(:not_a_single_letter, :letter_already_guessed) }
      end
    end
  end

  describe "#submit" do
    before do
      allow(game).to receive(:letter_already_guessed?).and_return(false)
    end

    it "calls Game#guess_letter with @input" do
      inputs_to_guesses.each do |input, guess|
        expect(game).to receive(:guess_letter).with(input.upcase)

        guess.submit
      end
    end
  end
end
