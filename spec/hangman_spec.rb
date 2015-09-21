require "hangman"

RSpec.describe Hangman do

  shared_context 'new Hangman object' do
      before do
        @hangman = Hangman.new('INSECT')
      end
  end
  shared_context 'Hangman object with one correct guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('I')
      end
  end
  shared_context 'Hangman object with one incorrect guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('B')
      end
  end

  describe '#lives_left with new Hangman object' do
    include_context 'new Hangman object'
    it 'returns 9 lives left' do
      expect(@hangman.lives_left).to eq(9)
    end
  end
  describe '#lives_left' do
    context "New Hangman object" do
      before do
        @hangman = Hangman.new('INSECT')
      end
      it 'returns 9 lives left' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
    context 'Hangman object with correct guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('I')
      end
      it 'returns 9 lives left' do
        expect(@hangman.lives_left).to eq(9)
      end
    end
    context 'Hangman object with incorrect guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('B')
      end
      it 'returns 8 lives left' do
        expect(@hangman.lives_left).to eq(8)
      end
    end
    context 'Hangman object with 9 incorrect guesses' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('B')
      end
      it 'returns 8 lives left' do
        expect(@hangman.lives_left).to eq(8)
      end
    end
  end

  describe '#word_status' do
    context 'New Hangman object' do
      before do
        @hangman = Hangman.new('INSECT')
      end
      it 'returns an array with 7 nils' do
        expect(@hangman.lives_left).to eq([nil, nil, nil, nil, nil, nil, nil])
      end
    end
    context 'Hangman object with correct guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('I')
      end
      it 'returns an array with \'I\' and 6 nils' do
        expect(@hangman.lives_left).to eq(['I', nil, nil, nil, nil, nil, nil])
      end
    end
    context 'Hangman object with incorrect guess' do
      before do
        @hangman = Hangman.new('INSECT')
        @hangman.guess_letter('B')
      end
      it 'returns an array with 7 nils' do
        expect(@hangman.lives_left).to eq([nil, nil, nil, nil, nil, nil, nil])
      end
    end
  end

end
