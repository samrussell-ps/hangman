require "console_interface"

# this is a really thin wrapper for $stdin
# it will make porting to Rails easier
RSpec.describe ConsoleInterface do
  let(:console_interface) { ConsoleInterface.new }

  describe "#get_input" do
    context "user types a string" do
      it "returns the string" do
        expect(console_interface).to receive(:readline).and_return("valid input\n")
        expect(console_interface.get_input).to eq("valid input")
      end
    end

    context "user types a char" do
      it "returns char" do
        expect(console_interface).to receive(:readline).and_return("4\n")
        expect(console_interface.get_input).to eq("4")
      end
    end

    context "user hits enter" do
      let(:user_input) { "\n" }
      it "returns \"\"" do
        expect(console_interface).to receive(:readline).and_return("\n")
        expect(console_interface.get_input).to eq("")
      end
    end
  end

  describe "#display_output" do
    it "calls puts" do
      expect(console_interface).to receive(:puts).with("sample data")
      console_interface.display_output("sample data")
    end
  end

end
