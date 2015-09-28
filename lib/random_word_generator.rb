# this class returns random words
class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"

  # query
  def self.random_word
    File.readlines("./data/wordsEn.txt").sample.chomp
  end
end

