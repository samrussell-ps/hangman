require "spec_helper"
require "response"

RSpec.describe Response do
  let(:dummy_symbol) { :dummy_symbol }
  let(:dummy_text) { "dummy text" }
  subject(:response) { Response.new(dummy_symbol, dummy_text) }

  it "has a status of :dummy_symbol" do
    expect(response.status).to eq(:dummy_symbol)
  end

  describe "#to_s" do
    subject(:to_s) { response.to_s }

    it { is_expected.to eq dummy_text }
  end
end
