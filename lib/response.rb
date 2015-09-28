# This class contains output for the user
# It contains
# - a prompt
class Response
  attr_reader :prompt

  def initialize(prompt)
    @prompt = prompt
  end

  def to_s
    @prompt
  end
end

class ErrorResponse < Response
  attr_reader :prompt
  attr_reader :alert

  def initialize(prompt, alert)
    @prompt = prompt
    @alert = alert
  end

  def to_s
    @alert + "\n" + @prompt
  end
end
