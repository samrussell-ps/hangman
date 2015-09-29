require "spec_helper"
require "controller"
require "game"
require "console_interface"
require "response"

RSpec.describe Controller do
  let(:game) { instance_double("Game") }
  let(:user_interface) { instance_double("ConsoleInterface") }
  subject(:controller) { Controller.new(game, user_interface) }

  describe "#run" do
    before do
      # run through the loop once
      allow(game).to receive(:finished?).and_return(false, true)

      # mock user_interface to not bump stdin/stdout
      allow(user_interface).to receive(:display_output)
      allow(user_interface).to receive(:get_input)
    end

    # test outgoing command
    it "gets input" do
      # don't and_call_original as it relies on stdin
      expect(user_interface).to receive(:get_input)
      
      controller.run
    end

    # test outgoing command
    it "prompts the user" do
      # don't and_call_original as it relies on stdout
      expect(user_interface).to receive(:display_output) do |args|
        expect(args.status).to eq(:continue)
      end
      
      controller.run
    end

    # test outgoing command
    context "when letter hasn't been guessed" do
      it "guesses the letter" do
        # don't and_call_original as it relies on stdin
        expect(user_interface).to receive(:get_input).and_return("A")
        expect(game).to receive(:letter_has_been_guessed?).with("A").and_return(false)
        expect(game).to receive(:guess_letter)
        
        controller.run
      end
    end

    context "when letter has been guessed" do
      # test outgoing command
      it "sets an alert" do
        # don't and_call_original as it relies on stdin
        expect(user_interface).to receive(:get_input).and_return("A")
        expect(game).to receive(:letter_has_been_guessed?).with("A").and_return(true)
        expect(game).to_not receive(:guess_letter)
        expect(user_interface).to receive(:display_output) do |args|
          expect(args.status).to eq(:continue_with_alert)
        end
        
        controller.run
      end
    end

    # TODO
    context "when game is won" do

    end

    # TODO
    context "when game is lost" do
    end
  end
end
