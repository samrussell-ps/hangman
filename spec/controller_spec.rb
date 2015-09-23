require "controller"
require "game"
require "console_interface"

RSpec.describe Controller do
  let(:game) { Game.new("SAUSAGE") }
  let(:user_interface) { ConsoleInterface.new }
  let(:controller) { Controller.new(game, user_interface) }
  describe "#valid_input?" do
    let(:input) { nil }
    let(:valid) { controller.valid_input?(input) }
    context "when input is \"A\"" do
      let(:input) { "A" }
      it { expect(valid).to be_truthy }
    end
    context "when input is \"a\"" do
      let(:input) { "a" }
      it { expect(valid).to be_truthy }
    end
    context "when input is \"?\"" do
      let(:input) { "?" }
      it { expect(valid).to be_falsey }
    end
    context "when input is \"2\"" do
      let(:input) { "2" }
      it { expect(valid).to be_falsey }
    end
    context "when input is nil" do
      let(:input) { nil }
      it { expect(valid).to be_falsey }
    end
    context "when input is \"AB\"" do
      let(:input) { "AB" }
      it { expect(valid).to be_falsey }
    end
  end
  # this takes masked_letters from Game
  # turns it into a word for display
  # ... belongs to the View?
  describe "#masked_word" do
    subject { controller.masked_word }
    context "with no guesses" do
      it { is_expected.to eq(".......") }
    end
    context "with \"A\" guessed" do
      before { game.guess_letter("A") }
      it { is_expected.to eq(".A..A..") }
    end
  end
  describe "#run" do
    # not very DRY, there must be a way to improve this
    # idea is to test the Controller#run loop, how to reuse mocks?
    context "when user enters \"a\"" do
      it "validates user input" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("a")
        expect(controller).to receive(:valid_input?)
        # this seems wrong... should be in a before? subject maybe?
        expect(controller.run).to be nil
      end
      it "passes \"A\" to Game#guess_letter" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("a")
        expect(game).to receive(:guess_letter).with("A")
        expect(controller.run).to be nil
      end
      it "calls ConsoleInterface#display_output at least once" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("a")
        expect(user_interface).to receive(:display_output).at_least(:once)
        expect(controller.run).to be nil
      end
    end
    context "when user enters \"7\"" do
      it "validates user input" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("7")
        expect(controller).to receive(:valid_input?)
        expect(controller.run).to be nil
      end
      it "doesn't pass anything to Game#guess_letter" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("7")
        expect(game).to_not receive(:guess_letter)
        expect(controller.run).to be nil
      end
      it "calls ConsoleInterface#display_output at least once" do
        expect(game).to receive(:finished?).and_return(false, true)
        expect(user_interface).to receive(:get_input).and_return("a")
        expect(user_interface).to receive(:display_output).at_least(:once)
        expect(controller.run).to be nil
      end
    end
  end
end
