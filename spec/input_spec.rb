require "spec_helper"
require "input"

RSpec.describe Input do
  let(:user_data) { nil }
  let(:input) { Input.new(user_data) }
  describe "#groom" do
    subject { input.groom }
    context "with a string" do
      let(:user_data) { "AB" }
      it { is_expected.to be_nil }
    end
    
    context "with a number" do
      let(:user_data) { "3" }
      it { is_expected.to be_nil }
    end
    
    context "with a symbol" do
      let(:user_data) { "<" }
      it { is_expected.to be_nil }
    end

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
