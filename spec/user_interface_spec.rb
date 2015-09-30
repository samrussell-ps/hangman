require "user_interface"
require "game"

RSpec.describe UserInterface do
  let(:game) { instance_double("Game") }
  subject(:user_interface) { UserInterface.new(game) }

  before do
    allow(game).to receive(:lives_left)
    allow(game).to receive(:word_progress_string)
    allow(game).to receive(:word)
  end

  describe "#display_game_state" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_game_state
    end
  end

  describe "#user_input" do
    let(:test_input) { "test input\n" }
    let(:expected_output) { "test input" }

    before do
      allow(user_interface).to receive(:readline).and_return(test_input)
    end

    it "strips newlines" do
      expect(user_interface.user_input).to eq(expected_output)
    end
  end

  describe "#display_alert" do
    let(:test_alert) { "test alert" }

    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_alert(test_alert)
    end
  end

  describe "#display_game_won_message" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_game_won_message
    end
  end

  describe "#display_game_lost_message" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_game_lost_message
    end
  end
end
