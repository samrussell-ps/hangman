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
      allow(game).to receive(:finished?).and_return(false, true)
      allow(user_talker).to receive(:data_from_user)
      allow(user_talker).to receive(:prompt_user)
      allow(user_talker).to receive(:game_finished_message)
    end
    
    after do
      controller.run
    end
    
    it "gets input" do
      expect(user_talker).to receive(:data_from_user)
    end

    it "prompts the user" do
      expect(user_talker).to receive(:prompt_user)
    end

    context "when letter hasn't been guessed" do
      it "guesses the letter" do
        allow(user_talker).to receive(:data_from_user).and_return('A')
        expect(game).to receive(:guess_letter)
      end
    end

    context "when letter has been guessed" do
      before do
        game.guess_letter("A")
      end

      after do
      end

      it "sets an error" do
        expect(user_talker).to receive(:data_from_user).and_return("A")
        expect(game).to_not receive(:guess_letter)
        controller.run
        expect(user_talker.error).to be
      end
    end
  end
end
