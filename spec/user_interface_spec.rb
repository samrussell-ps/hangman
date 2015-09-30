require "user_interface"
require "game"

RSpec.describe UserInterface do
  let(:game) { instance_double("Game") }
  subject(:user_interface) { UserInterface.new(game) }

  before do
    allow(game).to receive(:lives_left)
    allow(game).to receive(:word_progress).and_return([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    allow(game).to receive(:word).and_return("TELEPHONE")
  end

  describe "#display_game_state" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_game_state
    end
  end

  describe "#ask_for_user_input" do
    let(:test_input) { "test input\n" }
    let(:expected_output) { "test input" }

    before do
      allow(user_interface).to receive(:readline).and_return(test_input)
    end

    it "strips newlines" do
      expect(user_interface.ask_for_user_input).to eq(expected_output)
    end
  end

  describe "#display_bad_input_alert" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_bad_input_alert
    end
  end

  describe "#display_letter_already_guessed_alert" do
    it "calls puts" do
      expect(user_interface).to receive(:puts).at_least(:once)

      user_interface.display_letter_already_guessed_alert
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
