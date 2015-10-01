require "spec_helper"
require "input_validator"
require "game"

RSpec.describe InputValidator do
  let(:user_data) { nil }
  let(:game) { instance_double("Game") }
  let(:input_validator) { InputValidator.new(game) }

  describe "#call" do
    let(:user_data) { nil }
    subject(:valid_input) { input_validator.call(user_data) }
    
    context "when letter hasn't been guessed" do
      before do
        allow(game).to receive(:letter_already_guessed?).and_return(false)
      end

      context "with a string of length 2" do
        let(:user_data) { "AB" }

        it { is_expected.to be :not_a_single_letter }
      end
      
      context "with a number" do
        let(:user_data) { "3" }

        it { is_expected.to be :not_a_single_letter }
      end
      
      context "with a symbol" do
        let(:user_data) { "<" }

        it { is_expected.to be :not_a_single_letter }
      end

      context "with a lowercase character" do
        let(:user_data) { "c" }
        let(:valid_user_data) { "C" }

        it { is_expected.to be true }
      end
      
      context "with an uppercase character" do
        let(:user_data) { "C" }
        let(:valid_user_data) { "C" }

        it { is_expected.to be true }
      end
    end

    context "when letter has been guessed" do
      before do
        allow(game).to receive(:letter_already_guessed?).with(match(/[A-Za-z]/)).and_return(true)
      end

      context "with a lowercase character" do
        let(:user_data) { "c" }

        it { is_expected.to be :letter_already_guessed }
      end
      
      context "with an uppercase character" do
        let(:user_data) { "C" }

        it { is_expected.to be :letter_already_guessed }
      end
    end
  end
end
