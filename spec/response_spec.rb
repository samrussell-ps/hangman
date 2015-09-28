require "spec_helper"
require "response"

RSpec.describe GameContinueResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameContinueResponse.new(game) }

  describe "#to_s" do
    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end

  describe "GamePresenter" do
    subject { GameContinueResponse::GamePresenter.new(game).to_s }

    context "with no guesses" do
      it { is_expected.to eq(".......") }
    end

    context "with 'A' guessed" do
      before { game.guess_letter("A") }
      it { is_expected.to eq(".A..A..") }
    end
  end
end

RSpec.describe GameContinueWithAlertResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameContinueWithAlertResponse.new(game, 'alert string') }

  describe "#to_s" do
    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end

RSpec.describe GameFinishedWonResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameFinishedWonResponse.new(game) }

  describe "#to_s" do
    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end

RSpec.describe GameFinishedLostResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameFinishedLostResponse.new(game) }

  describe "#to_s" do
    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end
