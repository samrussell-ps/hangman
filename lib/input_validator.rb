class InputValidator
  def self.valid?(input)
    is_a_single_letter?(input)
  end

  private

  def self.is_a_single_letter?(input)
    !!input.match(/\A[[:alpha:]]\z/)
  end
end
