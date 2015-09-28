require "spec_helper"
require "user_talker"
require "guessed_letter"
require "game"

RSpec.describe UserTalker do
  let(:game) { Game.new("SAUSAGE") }
  let(:user_interface) { ConsoleInterface.new }
  subject(:user_talker) { UserTalker.new(game, user_interface) }

  describe "#prompt_user" do
    context "there is an error" do
      before do
        user_talker.error = "This is an error"
      end

      after do
        user_talker.prompt_user
      end

      it "Sends an ErrorResponse to ConsoleInterface" do
        expect(user_interface).to receive(:display_output).with(an_instance_of(ErrorResponse))
      end
    end

    context "there is no error" do
      after do
        user_talker.prompt_user
      end

      it "Sends a Response to ConsoleInterface" do
        expect(user_talker.error).to_not be
        expect(user_interface).to receive(:display_output).with(an_instance_of(Response))
      end
    end
  end

  describe "#game_finished_message" do
      after do
        user_talker.game_finished_message
      end

      it "Sends a Response to ConsoleInterface" do
        expect(user_interface).to receive(:display_output).with(an_instance_of(Response))
      end
  end

  describe "#letter_from_user" do
    let(:user_input) { nil }
    subject(:data_from_user) { user_talker.data_from_user }

    before do
      allow(user_interface).to receive(:get_input).and_return(user_input)
    end
    
    context "when user enters 'a'" do
      let(:user_input) { "a" }

      it { is_expected.to be_an_instance_of(GuessedLetter) }
      it "gives 'A' as a string" do
        expect(data_from_user.to_s).to eq("A")
      end
    end

    context "when user enters '7'" do
      let(:user_input) { "7" }

      it { is_expected.to be nil }
    end
  end

  # this takes masked_letters from Game
  # turns it into a word for display
  # ... belongs to the View?
  # common prefix = possibly needs its own class
  describe "GamePresenter" do
    subject { UserTalker::GamePresenter.new(game).to_s }

    context "with no guesses" do
      it { is_expected.to eq(".......") }
    end

    context "with 'A' guessed" do
      before { game.guess_letter("A") }
      it { is_expected.to eq(".A..A..") }
    end
  end
end
