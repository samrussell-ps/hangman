require "spec_helper"
require "response"

RSpec.describe GameContinueResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameContinueResponse.new(game) }

  it "returns a string" do
    expect(response.to_s).to be_an_instance_of(String)
  end

  it "is longer than 0 characters" do
    expect(response.to_s.size).to be > 0
  end

  # this takes masked_letters from Game
  # turns it into a word for display
  # ... belongs to the View?
  # common prefix = possibly needs its own class
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

  it "returns a string" do
    expect(response.to_s).to be_an_instance_of(String)
  end

  it "is longer than 0 characters" do
    expect(response.to_s.size).to be > 0
  end
end

RSpec.describe GameFinishedWonResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameFinishedWonResponse.new(game) }

  it "returns a string" do
    expect(response.to_s).to be_an_instance_of(String)
  end

  it "is longer than 0 characters" do
    expect(response.to_s.size).to be > 0
  end
end

RSpec.describe GameFinishedLostResponse do
  let(:game) { Game.new("SAUSAGE") }
  let(:response) { GameFinishedLostResponse.new(game) }

  it "returns a string" do
    expect(response.to_s).to be_an_instance_of(String)
  end

  it "is longer than 0 characters" do
    expect(response.to_s.size).to be > 0
  end
end
