require "spec_helper"
require "controller"
require "game"

RSpec.describe Controller do
  let(:game) { instance_double("Game") }
  let(:user_interface) { instance_double("UserInterface") }
  subject(:controller) { Controller.new(game, user_interface) }

  describe "#run" do
    before do
      allow(game).to receive(:won?)
      allow(user_interface).to receive(:display_game_won_message)
      allow(user_interface).to receive(:display_game_lost_message)
      allow(user_interface).to receive(:display_alert)
    end

    context "when game is still running" do
      let(:letter_to_guess) { "A" }

      before do
        # run through the loop once
        allow(game).to receive(:finished?).and_return(false, true)

        # stubs
        allow(user_interface).to receive(:display_game_state)
        allow(user_interface).to receive(:ask_for_user_input).and_return(letter_to_guess)
        allow(game).to receive(:guess_letter)
      end

      it "displays game state" do
        allow(game).to receive(:letter_already_guessed?)
        expect(user_interface).to receive(:display_game_state)

        controller.run
      end

      context "with invalid input 'invalid input'" do
        let(:letter_to_guess) { "invalid input" }

        before do
          allow(user_interface).to receive(:ask_for_user_input).and_return(letter_to_guess)
          allow(game).to receive(:letter_already_guessed?).and_return(false)
        end

        it "doesn't guess the letter" do
          expect(game).to_not receive(:guess_letter)

          controller.run
        end

        it "calls display_alert(:not_a_single_letter)" do
          expect(user_interface).to receive(:display_alert).with(:not_a_single_letter)

          controller.run
        end
      end

      context "with valid uppercase input 'A'" do
        let(:letter_to_guess) { "A" }

        before do
          allow(user_interface).to receive(:ask_for_user_input).and_return(letter_to_guess)
          allow(game).to receive(:guess_letter)
        end

        context "when letter has already been guessed" do
          before do
            allow(game).to receive(:letter_already_guessed?).and_return(true)
          end

          it "doesn't guess the letter" do
            expect(game).to_not receive(:guess_letter)

            controller.run
          end

          it "calls display_alert(:letter_already_guessed)" do
            expect(user_interface).to receive(:display_alert).with(:letter_already_guessed)

            controller.run
          end

          it "doesn't call display_alert(:not_a_single_letter)" do
            expect(user_interface).to_not receive(:display_alert).with(:not_a_single_letter)

            controller.run
          end
        end

        context "when letter hasn't yet been guessed" do
          before do
            allow(game).to receive(:letter_already_guessed?).and_return(false)
          end

          it "guesses the letter" do
            expect(game).to receive(:guess_letter).with(letter_to_guess)

            controller.run
          end

          it "doesn't call display_alert(:letter_already_guessed)" do
            expect(user_interface).to_not receive(:display_alert).with(:letter_already_guessed)

            controller.run
          end

          it "doesn't call display_alert(:not_a_single_letter)" do
            expect(user_interface).to_not receive(:display_alert).with(:not_a_single_letter)

            controller.run
          end
        end
      end

      context "with valid lowercase input 'a'" do
        let(:letter_to_guess) { "a" }

        before do
          allow(user_interface).to receive(:ask_for_user_input).and_return(letter_to_guess)
        end

        context "when letter has already been guessed" do
          before do
            allow(game).to receive(:letter_already_guessed?).and_return(true)
          end

          it "doesn't guess the letter" do
            expect(game).to_not receive(:guess_letter)

            controller.run
          end

          it "calls display_alert(:letter_already_guessed)" do
            expect(user_interface).to receive(:display_alert).with(:letter_already_guessed)

            controller.run
          end

          it "doesn't call display_alert(:not_a_single_letter)" do
            expect(user_interface).to_not receive(:display_alert).with(:not_a_single_letter)

            controller.run
          end
        end

        context "when letter hasn't yet been guessed" do
          before do
            allow(game).to receive(:letter_already_guessed?).and_return(false)
          end

          it "guesses the letter" do
            expect(game).to receive(:guess_letter).with(letter_to_guess.upcase)

            controller.run
          end

          it "doesn't call display_alert(:letter_already_guessed)" do
            expect(user_interface).to_not receive(:display_alert).with(:letter_already_guessed)

            controller.run
          end

          it "doesn't call display_alert(:not_a_single_letter)" do
            expect(user_interface).to_not receive(:display_alert).with(:not_a_single_letter)

            controller.run
          end
        end
      end
    end

    context "when game is finished" do
      before do
        # jump to end
        allow(game).to receive(:finished?).and_return(true)
      end

      context "when game is won" do
        before do
          allow(game).to receive(:won?).and_return(true)
        end

        it "displays the game won message" do
          expect(user_interface).to receive(:display_game_won_message)

          controller.run
        end
      end

      context "when game is lost" do
        before do
          allow(game).to receive(:won?).and_return(false)
        end

        it "displays the game lost message" do
          expect(user_interface).to receive(:display_game_lost_message)

          controller.run
        end
      end
    end
  end
end
