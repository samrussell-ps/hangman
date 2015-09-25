# TODO: change to GuessedLetter
class GuessedLetter
  # wraps a string of input from user
  # has bool for "valid"
  # returns "groom" data (i.e. uppercase)
  def initialize(text_from_user)
    @text_from_user = text_from_user.to_s
  end

  def to_s
    @text_from_user.upcase
  end
  
  def valid?
    input_is_a_single_letter?
  end

  private

  def input_is_a_single_letter?
    input_is_made_only_of_letters? && input_is_a_single_character?
  end

  def input_is_made_only_of_letters?
    !@text_from_user.match(/\A[[:alpha:]]+\z/).nil?
  end

  def input_is_a_single_character?
    @text_from_user.size == 1
  end
end
