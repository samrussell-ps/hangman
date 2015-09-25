require "spec_helper"
require "guessed_letter"

RSpec.describe GuessedLetter do
  let(:user_data) { nil }
  let(:guessed_letter) { GuessedLetter.new(user_data) }

  describe "#valid?" do
    subject { guessed_letter.valid? }

    context "with a string of length 2" do
      let(:user_data) { "AB" }

      it { is_expected.to be false }
    end
    
    context "with a number" do
      let(:user_data) { "3" }

      it { is_expected.to be false }
    end
    
    context "with a symbol" do
      let(:user_data) { "<" }

      it { is_expected.to be false }
    end

    context "with a lowercase character" do
      let(:user_data) { "c" }

      it { is_expected.to be true }
    end
    
    context "with an uppercase character" do
      let(:user_data) { "C" }

      it { is_expected.to be true }
    end
  end
  describe "#to_s" do
    subject { guessed_letter.to_s }

    context "with a lowercase character" do
      let(:user_data) { "c" }

      it { is_expected.to eq("C") }
    end
    
    context "with an uppercase character" do
      let(:user_data) { "C" }

      it { is_expected.to eq("C") }
    end
  end
end
