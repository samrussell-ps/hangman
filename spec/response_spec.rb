require "spec_helper"
require "response"

RSpec.describe Response do
  describe "#initialize" do
    context "with a prompt" do
      subject(:response) { Response.new("test response") }

      it "has a prompt" do
        expect(response.prompt).to be_a_kind_of(String)
      end
    end
  end
end

RSpec.describe ErrorResponse do
  describe "#initialize" do
    context "with a prompt and an alert" do
      subject(:response) { ErrorResponse.new("test response", "alert") }

      it "has a prompt" do
        expect(response.prompt).to be_a_kind_of(String)
      end
      it "has an alert" do
        expect(response.prompt).to be_a_kind_of(String)
      end
    end
  end
end
