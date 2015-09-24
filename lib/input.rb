class Input
  # wraps a string of input from user
  # has bool for "valid"
  # returns "groom" data (i.e. uppercase)
  def initialize(text_from_user)
    @text_from_user = text_from_user
  end

  def groom
    if valid?
      @text_from_user.upcase
    else
      nil
    end
  end

  private

  def valid?
    @text_from_user != nil && @text_from_user.match(/\A[[:alpha:]]+\z/) && @text_from_user.size == 1
  end
end
