# this class returns random words
class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"

  # query
  def self.random_word
    @@word_list ||= File.readlines(WORDLIST_FILENAME)

    @@word_list.sample.chomp
  end
end

