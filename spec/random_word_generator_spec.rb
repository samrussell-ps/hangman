require "spec_helper"
require "random_word_generator"

RSpec.describe RandomWordGenerator do
  describe "#random_word" do
    subject(:random_word){ RandomWordGenerator.random_word }

    it 'returns a random word' do
      words = 50.times.map { RandomWordGenerator.random_word } 

      words.each do |word|
        expect(word).to be_a String
        expect(word).not_to be_empty
      end

      expect(words.uniq.count).to be > 40
    end
  end
end
