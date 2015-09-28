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

      it "Sends a GameContinueWithAlertResponse to ConsoleInterface" do
        expect(user_interface).to receive(:display_output).with(an_instance_of(GameContinueWithAlertResponse))
      end
    end

    context "there is no error" do
      after do
        user_talker.prompt_user
      end

      it "Sends a GameContinueResponse to ConsoleInterface" do
        expect(user_talker.error).to_not be
        expect(user_interface).to receive(:display_output).with(an_instance_of(GameContinueResponse))
      end
    end
  end

  describe "#game_finished_message" do
      after do
        user_talker.game_finished_message
      end

      it "Sends a GameFinishedResponse to ConsoleInterface" do
        expect(user_interface).to receive(:display_output).with(a_kind_of(GameFinishedResponse))
      end

      context "When game is won" do
        before do
          allow(game).to receive(:won?).and_return(true)
          allow(game).to receive(:lost?).and_return(false)
        end

        it "Sends a GameFinishedWonResponse to ConsoleInterface" do
          expect(user_interface).to receive(:display_output).with(a_kind_of(GameFinishedWonResponse))
        end
      end

      context "When game is lost" do
        before do
          allow(game).to receive(:lost?).and_return(true)
          allow(game).to receive(:won?).and_return(false)
        end

        it "Sends a GameFinishedLostResponse to ConsoleInterface" do
          expect(user_interface).to receive(:display_output).with(a_kind_of(GameFinishedLostResponse))
        end
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
end
