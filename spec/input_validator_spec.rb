require "spec_helper"
require "input_validator"
require "user_interface"
require "game"

RSpec.describe InputValidator do
  let(:user_data) { nil }
  let(:game) { instance_double("Game") }
  let(:user_interface) { instance_double("UserInterface") }
  let(:input_validator) { InputValidator.new(game, user_interface) }

  describe "#convert_to_valid_form" do
    let(:user_data) { nil }
    subject(:valid_input) { input_validator.convert_to_valid_form(user_data) }
    
    before do
      allow(user_interface).to receive(:display_letter_already_guessed_alert)
      allow(user_interface).to receive(:display_bad_input_alert)
    end

    context "when letter hasn't been guessed" do
      before do
        allow(game).to receive(:letter_has_been_guessed?).and_return(false)
      end

      context "with a string of length 2" do
        let(:user_data) { "AB" }

        it { is_expected.to be nil }

        it "doesn't call display_letter_already_guessed_alert" do
          expect(user_interface).to_not receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "calls display_bad_input_alert" do
          expect(user_interface).to receive(:display_bad_input_alert)

          valid_input
        end
      end
      
      context "with a number" do
        let(:user_data) { "3" }

        it { is_expected.to be nil }

        it "doesn't call display_letter_already_guessed_alert" do
          expect(user_interface).to_not receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "calls display_bad_input_alert" do
          expect(user_interface).to receive(:display_bad_input_alert)

          valid_input
        end
      end
      
      context "with a symbol" do
        let(:user_data) { "<" }

        it { is_expected.to be nil }

        it "doesn't call display_letter_already_guessed_alert" do
          expect(user_interface).to_not receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "calls display_bad_input_alert" do
          expect(user_interface).to receive(:display_bad_input_alert)

          valid_input
        end
      end

      context "with a lowercase character" do
        let(:user_data) { "c" }
        let(:valid_user_data) { "C" }

        it { is_expected.to eq(valid_user_data) }

        it "doesn't call display_letter_already_guessed_alert" do
          expect(user_interface).to_not receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "doesn't call display_bad_input_alert" do
          expect(user_interface).to_not receive(:display_bad_input_alert)

          valid_input
        end
      end
      
      context "with an uppercase character" do
        let(:user_data) { "C" }
        let(:valid_user_data) { "C" }

        it { is_expected.to eq(valid_user_data) }

        it "doesn't call display_letter_already_guessed_alert" do
          expect(user_interface).to_not receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "doesn't call display_bad_input_alert" do
          expect(user_interface).to_not receive(:display_bad_input_alert)

          valid_input
        end
      end
    end

    context "when letter has been guessed" do
      before do
        allow(game).to receive(:letter_has_been_guessed?).with(match(/[a-z]/)).and_return(false)
        allow(game).to receive(:letter_has_been_guessed?).with(match(/[A-Z]/)).and_return(true)
      end

      context "with a lowercase character" do
        let(:user_data) { "c" }

        it { is_expected.to be nil }

        it "calls display_letter_already_guessed_alert" do
          expect(user_interface).to receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "doesn't call display_bad_input_alert" do
          expect(user_interface).to_not receive(:display_bad_input_alert)

          valid_input
        end
      end
      
      context "with an uppercase character" do
        let(:user_data) { "C" }

        it { is_expected.to be nil }

        it "calls display_letter_already_guessed_alert" do
          expect(user_interface).to receive(:display_letter_already_guessed_alert)

          valid_input
        end

        it "doesn't call display_bad_input_alert" do
          expect(user_interface).to_not receive(:display_bad_input_alert)

          valid_input
        end
      end
    end
  end
end
