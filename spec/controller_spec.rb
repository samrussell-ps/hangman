require "spec_helper"
require "controller"
require "game"
require "console_interface"
require "response"
require "user_talker"

RSpec.describe Controller do
  let(:game) { Game.new("SAUSAGE") }
  let(:user_interface) { ConsoleInterface.new }
  let(:user_talker) { UserTalker.new(game, user_interface) }
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
        allow(user_talker).to receive(:letter_from_user).and_return('A')
        expect(game).to receive(:guess_letter)
        controller.run
      end
    end

    context "when letter has been guessed" do
      before do
        game.guess_letter("A")
      end

      it "sets an alert" do
        expect(user_talker).to receive(:letter_from_user).and_return("A")
        expect(game).to_not receive(:guess_letter)
        controller.run
        expect(user_talker.alert).to be
      end
    end
  end
end
