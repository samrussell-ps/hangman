require "delegate"

class Response
end

class GameContinueResponse < Response
  def initialize(game)
    @game = GamePresenter.new(game)
  end

  # query
  def to_s
    prompt
  end

  private

  def prompt
    "The word so far: #{@game}\n" +
    "You have #{@game.lives_left} lives left\n" +
    "Guess a letter\n"
  end

  class GamePresenter < SimpleDelegator
    # query
    def to_s
      masked_letters.map { |letter| if letter then letter else "." end }.join
    end
  end
end

class GameContinueWithAlertResponse < GameContinueResponse
  def initialize(game, alert)
    super(game)
    @alert = alert
  end

  # query
  def to_s
    @alert + "\n" + prompt
  end
end

class GameFinishedResponse < Response
  def initialize(game)
    @game = game
  end

  # query
  def result
    "The word was #{@game.word}"
  end
end

class GameFinishedWonResponse < GameFinishedResponse
  def initialize(game)
    super(game)
  end

  # query
  def to_s
    "You won!\n" + result
  end
end

class GameFinishedLostResponse < GameFinishedResponse
  def initialize(game)
    super(game)
  end

  # query
  def to_s
    "You lost!\n" + result
  end
end
