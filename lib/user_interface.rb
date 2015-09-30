class UserInterface
  def initialize(game)
    @game = game
  end

  def display_game_state
    puts "You have #{@game.lives_left} lives left"
    puts "Word progress: #{@game.word_progress}"
  end

  def user_input
    readline.chomp
  end

  def display_alert(alert)
    puts alert
  end

  def display_game_won_message
    puts "Congratulations, you won!"
    display_word
  end

  def display_game_lost_message
    puts "Aww, you lost!"
    display_word
  end

  private

  def display_word
    puts "The word was #{@game.word}"
  end
end
