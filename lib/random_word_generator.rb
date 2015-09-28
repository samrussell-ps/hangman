# this class returns random words
class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"

  # query
  def self.random_word
    File.readlines(WORDLIST_FILENAME).sample.chomp
  end
end

