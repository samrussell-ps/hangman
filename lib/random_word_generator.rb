# this class returns random words
class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"
  def initialize(seed = Random.new_seed)
    @seeded_random_number_generator = Random.new(seed)
  end

  def random_word
    #File.readlines("./data/wordsEn.txt")[@seeded_random_number_generator.rand(get_number_of_words)]
    File.readlines("./data/wordsEn.txt")[rand(number_of_words)].chomp
  end

  private
  
  def number_of_words
    File.readlines("./data/wordsEn.txt").size
  end

end

