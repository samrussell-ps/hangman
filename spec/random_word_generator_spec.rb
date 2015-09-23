require "random_word_generator"

RSpec.describe RandomWordGenerator do
  describe "#random_word" do
    let(:random_word){ RandomWordGenerator.random_word }
    let(:number_of_lines) { 1000 }
    subject { random_word }
    it "should be \"triumviri\" when rand() returns 99999" do
      expect(RandomWordGenerator).to receive(:rand).and_return(99999)
      is_expected.to eq("triumviri")
    end
  end
end
