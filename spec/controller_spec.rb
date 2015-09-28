require "spec_helper"
require "controller"
require "game"
require "console_interface"
require "response"
require "user_talker"

RSpec.describe Controller do
  let(:game) { instance_double("Game") }
  let(:user_interface) { instance_double("ConsoleInterface") }
  let(:user_talker) { instance_double("UserTalker") }
  subject(:controller) { Controller.new(game, user_talker) }

  describe "#run" do
    before do
      # run through the loop once
      allow(game).to receive(:finished?).and_return(false, true)

      # mock user_talker to not bump stdin/stdout
      allow(user_talker).to receive(:letter_from_user)
      allow(user_talker).to receive(:prompt_user)
      allow(user_talker).to receive(:game_finished_message)
    end

    # test outgoing command
    it "gets input" do
      # don't and_call_original as it relies on stdin
      expect(user_talker).to receive(:letter_from_user)

      controller.run
    end

    # test outgoing command
    it "prompts the user" do
      # don't and_call_original as it relies on stdout
      expect(user_talker).to receive(:prompt_user)

      controller.run
    end

    # test outgoing command
    context "when letter hasn't been guessed" do
      it "guesses the letter" do
        # don't and_call_original as it relies on stdin
        expect(user_talker).to receive(:letter_from_user).and_return("A")
        expect(game).to receive(:letter_has_been_guessed?).with("A").and_return(false)
        expect(game).to receive(:guess_letter)

        controller.run
      end
    end

    context "when letter has been guessed" do
      # test outgoing command
      it "sets an alert" do
        # don't and_call_original as it relies on stdin
        expect(user_talker).to receive(:letter_from_user).and_return("A")
        expect(game).to receive(:letter_has_been_guessed?).with("A").and_return(true)
        expect(game).to_not receive(:guess_letter)
        expect(user_talker).to receive(:alert=)

        controller.run
      end
    end
  end
end
