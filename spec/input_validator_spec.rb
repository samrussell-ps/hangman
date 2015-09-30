require "spec_helper"
require "input_validator"

RSpec.describe InputValidator do
  let(:user_data) { nil }
  let(:input_validator) { InputValidator }

  describe "#valid?" do
    let(:user_data) { nil }
    subject { input_validator.valid?(user_data) }

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
end
