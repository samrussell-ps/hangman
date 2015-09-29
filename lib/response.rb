require "delegate"

class Response
  attr_reader :status

  def initialize(status, message)
    @status = status
    @message = message
  end

  def to_s
    @message
  end
end

  # TODO
  #def prompt
  #  "The word so far: #{@game}\n" +
  #  "You have #{@game.lives_left} lives left\n" +
  #  "Guess a letter\n"
  #end

  # TODO
  # this has moved around so many classes!
  #class GamePresenter < SimpleDelegator
  #  # query
  #  def to_s
  #    masked_letters.map { |letter| if letter then letter else "." end }.join
  #  end
  #end

  # TODO
  #def result
  #  "The word was #{@game.word}"
  #end
