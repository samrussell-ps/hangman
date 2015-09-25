# This class contains output for the user
# It contains
# - a prompt
# - any errors/alerts
class Response
  attr_reader :prompt
  attr_reader :alert

  def initialize(prompt, alert = nil)
    @prompt = prompt
    @alert = alert
  end
end
