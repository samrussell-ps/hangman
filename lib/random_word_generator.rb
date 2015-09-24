# this class returns random words
class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"

  def self.random_word
    File.readlines("./data/wordsEn.txt").sample.chomp
  end

  private
  
  def self.number_of_words
    File.readlines("./data/wordsEn.txt").size
  end

end

