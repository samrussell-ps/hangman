require "random_word_generator"

RSpec.describe RandomWordGenerator do
  let(:random_number_seed_1) { 1234 }
  let(:random_number_seed_2) { 2345 }
  let(:random_word_generator_1) { RandomWordGenerator.new(random_number_seed_1) }
  let(:random_word_generator_2) { RandomWordGenerator.new(random_number_seed_2) }
  describe '#get_random_word' do
    let(:random_word_1_with_seed_1){ random_word_generator_1.get_random_word }
    let(:random_word_2_with_seed_1){ random_word_generator_1.get_random_word }
    let(:random_word_1_with_seed_2){ random_word_generator_2.get_random_word }
    let(:random_word_2_with_seed_2){ random_word_generator_2.get_random_word }
    it 'returns different words when initialised with different seeds' do
      # test that we are getting word #123 from the file
      expect(random_word_generator).to receive(:rand).with(number_of_lines).and_return(123)
      #
      expect(random_word_1_with_seed_1).not_to eq(random_word_1_with_seed_2)
      expect(random_word_2_with_seed_1).not_to eq(random_word_1_with_seed_2)
      expect(random_word_1_with_seed_1).not_to eq(random_word_2_with_seed_2)
      expect(random_word_2_with_seed_1).not_to eq(random_word_2_with_seed_2)
    end
    # this isn't guaranteed to be true
    # there exists a seed where this fails, but chances are we won't use this seed
    it 'doesn\'t return the same word twice in a row' do
      expect(random_word_1_with_seed_1).not_to eq(random_word_2_with_seed_1)
      expect(random_word_1_with_seed_2).not_to eq(random_word_2_with_seed_2)
    end
    it 'is only alpha (a-z) characters)' do
      expect(random_word_1_with_seed_1.match(/^[[:alpha:]]+$/)).not_to eq(nil)
      expect(random_word_2_with_seed_1.match(/^[[:alpha:]]+$/)).not_to eq(nil)
      expect(random_word_1_with_seed_2.match(/^[[:alpha:]]+$/)).not_to eq(nil)
      expect(random_word_2_with_seed_2.match(/^[[:alpha:]]+$/)).not_to eq(nil)
    end
    it 'is more than 0 characters long' do
      expect(random_word_1_with_seed_1.size).to be > 0
      expect(random_word_2_with_seed_1.size).to be > 0
      expect(random_word_1_with_seed_2.size).to be > 0
      expect(random_word_2_with_seed_2.size).to be > 0
    end
  end
end
