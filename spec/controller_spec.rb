require "controller"
require "game"
require "console_interface"

RSpec.describe Controller do
  let(:game) { Game.new("SAUSAGE") }
  let(:user_interface) { ConsoleInterface.new }
  subject(:controller) { Controller.new(game, user_interface) }

  describe "#valid_input?" do
    let(:input) { nil }
    subject(:valid) { controller.valid_input?(input) }

    context "when input is \"A\"" do
      let(:input) { "A" }
      it { is_expected.to be_truthy }
    end

    context "when input is \"a\"" do
      let(:input) { "a" }
      it { is_expected.to be_truthy }
    end

    context "when input is \"?\"" do
      let(:input) { "?" }
      it { is_expected.to be_falsey }
    end

    context "when input is \"2\"" do
      let(:input) { "2" }
      it { is_expected.to be_falsey }
    end

    context "when input is nil" do
      let(:input) { nil }
      it { is_expected.to be_falsey }
    end

    context "when input is \"AB\"" do
      let(:input) { "AB" }
      it { is_expected.to be_falsey }
    end
  end

  # this takes masked_letters from Game
  # turns it into a word for display
  # ... belongs to the View?
  # common prefix = possibly needs its own class
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
    let(:user_input) { nil }

    before do
      allow(game).to receive(:finished?).and_return(false, true)
      allow(user_interface).to receive(:get_input).and_return(user_input)
      allow(user_interface).to receive(:display_output)
    end
    
    after do
      controller.run
    end
    
    context "when user enters \"a\"" do
      let(:user_input) { "a" }

      it "validates user input" do
        expect(controller).to receive(:valid_input?)
      end

      it "passes \"A\" to Game#guess_letter" do
        expect(game).to receive(:guess_letter).with("A")
      end

      it "calls ConsoleInterface#display_output at least once" do
        expect(user_interface).to receive(:display_output).at_least(:once)
      end
    end

    context "when user enters \"7\"" do
      let(:user_input) { "7" }

      it "validates user input" do
        expect(controller).to receive(:valid_input?)
      end

      it "doesn't pass anything to Game#guess_letter" do
        expect(game).to_not receive(:guess_letter)
      end

      it "calls ConsoleInterface#display_output at least once" do
        expect(user_interface).to receive(:display_output).at_least(:once)
      end
    end
  end
end
