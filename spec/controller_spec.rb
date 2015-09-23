require "controller"
require "game"

RSpec.describe Controller do
  let(:controller) { Controller.new }
  describe "#valid_input?" do
    let(:input) { nil }
    let(:valid) { controller.valid_input?(:input) }
    context "when input is \"A\"" do
      let(:input) { "A" }
      it { expect(valid).to be true }
    end
    context "when input is \"a\"" do
      let(:input) { "a" }
      it { expect(valid).to be true }
    end
    context "when input is \"?\"" do
      let(:input) { "?" }
      it { expect(valid).to be false }
    end
    context "when input is \"2\"" do
      let(:input) { "2" }
      it { expect(valid).to be false }
    end
    context "when input is nil" do
      let(:input) { nil }
      it { expect(valid).to be false }
    end
    context "when input is \"AB\"" do
      let(:input) { "AB" }
      it { expect(valid).to be false }
    end
  end
  describe "#submit_guess" do
    it "validates input" do
      expect(controller).to receive(:valid_input?)
    end
    # i want to test that this passes the data to the Game object
    # but i need a way to access this...
  end
end
