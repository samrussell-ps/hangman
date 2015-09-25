require "spec_helper"
require "console_interface"
require "response"

# this is a really thin wrapper for $stdin
# it will make porting to Rails easier
RSpec.describe ConsoleInterface do
  subject(:console_interface) { ConsoleInterface.new }

  describe "#get_input" do
    let(:user_input) { nil }
    let(:parsed_input) { nil }
    subject { console_interface.get_input }

    before do
      allow(console_interface).to receive(:readline).and_return(user_input)
    end

    context "user types a string" do
      let(:user_input) { "valid input\n" }
      let(:parsed_input) { "valid input" }

      it { is_expected.to eq(parsed_input) }
    end

    context "user types a char" do
      let(:user_input) { "4\n" }
      let(:parsed_input) { "4" }

      it { is_expected.to eq(parsed_input) }
    end

    context "user hits enter" do
      let(:user_input) { "\n" }
      let(:parsed_input) { "" }

      it { is_expected.to eq(parsed_input) }
    end
  end

  describe "#display_output" do
    let(:output) { Response.new("sample data") }

    it "passes the string to puts()" do
      expect(console_interface).to receive(:puts)
      console_interface.display_output(output)
    end
  end
end
