class InputValidator
  # query
  def self.valid?(input)
    is_a_single_letter?(input)
  end

  private

  def self.is_a_single_letter?(input)
    is_made_only_of_letters?(input) && is_a_single_character?(input)
  end

  def self.is_made_only_of_letters?(input)
    !input.match(/\A[[:alpha:]]+\z/).nil?
  end

  def self.is_a_single_character?(input)
    input.size == 1
  end
end
