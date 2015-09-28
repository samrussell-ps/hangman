require "spec_helper"
require "response"

RSpec.describe GameContinueResponse do
  let(:game) { instance_double("Game") }
  let(:response) { GameContinueResponse.new(game) }

  # test result
  describe "#to_s" do
    before do
      allow(game).to receive(:masked_letters).and_return([nil, nil, nil,
                                                        nil, nil, nil, nil])
      allow(game).to receive(:lives_left).and_return(9)
    end

    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end

  # test result
  describe "GamePresenter#to_s" do
    subject { GameContinueResponse::GamePresenter.new(game).to_s }

    context "with no guesses" do
      before do
        allow(game).to receive(:masked_letters).and_return([nil, nil, nil,
                                                          nil, nil, nil, nil])
      end

      it { is_expected.to eq(".......") }
    end

    context "with 'A' guessed" do
      before do
        allow(game).to receive(:masked_letters).and_return([nil, "A", nil,
                                                          nil, "A", nil, nil])
      end
      it { is_expected.to eq(".A..A..") }
    end
  end
end

RSpec.describe GameContinueWithAlertResponse do
  let(:game) { instance_double("Game") }
  let(:response) { GameContinueWithAlertResponse.new(game, 'alert string') }

  # test result
  describe "#to_s" do
    before do
      allow(game).to receive(:masked_letters).and_return([nil, nil, nil,
                                                        nil, nil, nil, nil])
      allow(game).to receive(:lives_left).and_return(9)
    end

    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end

RSpec.describe GameFinishedWonResponse do
  let(:game) { instance_double("Game") }
  let(:response) { GameFinishedWonResponse.new(game) }

  # test result
  describe "#to_s" do
    before do
      allow(game).to receive(:word).and_return("SAUSAGE")
    end

    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end

RSpec.describe GameFinishedLostResponse do
  let(:game) { instance_double("Game") }
  let(:response) { GameFinishedLostResponse.new(game) }

  # test result
  describe "#to_s" do
    before do
      allow(game).to receive(:word).and_return("SAUSAGE")
    end

    subject(to_s) { response.to_s }

    it { is_expected.to be_an_instance_of(String) }
    it "is longer than 0 characters" do
      expect(to_s.size).to be > 0
    end
  end
end
