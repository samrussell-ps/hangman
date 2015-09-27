# This class contains output for the user
# It contains
# - a prompt
class Response
  attr_reader :prompt

  def initialize(prompt)
    @prompt = prompt
  end
end

class ErrorResponse < Response
  attr_reader :prompt
  attr_reader :alert

  def initialize(prompt, alert = nil)
    @prompt = prompt
    @alert = alert
  end
end
