class RandomWordGenerator
  WORDLIST_FILENAME = "./data/wordsEn.txt"

  def self.next
    @@word_list ||= File.readlines(WORDLIST_FILENAME)

    @@word_list.sample.chomp
  end
end

