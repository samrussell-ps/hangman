require "spec_helper"
require "user_talker"
require "guessed_letter"

RSpec.describe UserTalker do
  let(:user_interface) { ConsoleInterface.new }
  subject(:user_talker) { UserTalker.new(user_interface) }

  describe "#prompt_user" do
    context "there is an error" do
      before do
        user_talker.error = "This is an error"
      end

      after do
        user_talker.prompt_user("Prompt")
      end

      it "Sends an ErrorResponse to ConsoleInterface" do
        expect(user_interface).to receive(:display_output).with(a_kind_of(ErrorResponse))
      end
    end

    context "there is ano error" do
      after do
        user_talker.prompt_user("Prompt")
      end

      it "Sends an ErrorResponse to ConsoleInterface" do
        expect(user_talker.error).to_not be
        # maybe want explicit ResponseWithoutError or the like?
        expect(user_interface).to receive(:display_output).with(an_instance_of(Response))
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
