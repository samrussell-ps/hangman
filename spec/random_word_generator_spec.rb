require "spec_helper"
require "random_word_generator"

RSpec.describe RandomWordGenerator do
  describe "#next" do
    let(:test_words_count) { 50 }
    let(:minimum_unique_words_count) { 40 }
    let(:random_word_generator) { RandomWordGenerator.new }
    let(:words) { test_words_count.times.map { random_word_generator.next } }

    it 'is a string' do
      words.each { |word| expect(word).to be_a String }
    end

    it 'is longer than 0 characters' do
      words.each { |word| expect(word.size).to be > 0 }
    end

    it 'is alpha characters' do
      words.each { |word| word.match(/\A[[:alpha:]]+\Z/) }
    end

    it 'is random' do
      expect(words.uniq.count).to be > 40
    end
  end
end
