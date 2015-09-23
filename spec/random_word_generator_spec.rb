require "random_word_generator"

RSpec.describe RandomWordGenerator do
  let(:random_word_generator) { RandomWordGenerator.new }
  describe "#random_word" do
    let(:random_word){ random_word_generator.random_word }
    let(:number_of_lines) { 1000 }
    subject { random_word }
    it "should be \"triumviri\" when rand() returns 99999" do
      expect(random_word_generator).to receive(:rand).and_return(99999)
      is_expected.to eq("triumviri")
    end
  end
end
