require "spec_helper"
require "controller"
require "game"
require "console_interface"
require "response"
require "user_talker"

RSpec.describe Controller do
  let(:game) { Game.new("SAUSAGE") }
  let(:user_interface) { ConsoleInterface.new }
  let(:user_talker) { UserTalker.new(user_interface) }
  subject(:controller) { Controller.new(game, user_talker) }

  describe "#run" do
    before do
      allow(game).to receive(:finished?).and_return(false, true)
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
  end

  # this takes masked_letters from Game
  # turns it into a word for display
  # ... belongs to the View?
  # common prefix = possibly needs its own class
  describe "GamePresenter" do
    subject { Controller::GamePresenter.new(game).to_s }

    context "with no guesses" do
      it { is_expected.to eq(".......") }
    end

    context "with 'A' guessed" do
      before { game.guess_letter("A") }
      it { is_expected.to eq(".A..A..") }
    end
  end
end
