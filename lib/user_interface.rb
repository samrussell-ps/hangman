class UserInterface
  def initialize(game)
    @game = game
  end

  def display_game_state
    puts "You have #{pluralise_lives} left"
    puts "Word progress: #{render_word_progress}"
  end

  def ask_for_user_input
    readline.chomp
  end

  def display_bad_input_alert
    puts "Bad input"
  end

  def display_letter_already_guessed_alert
    puts "That letter has already been guessed"
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

  def render_word_progress
    @game.word_progress.map { |char| char || "_" }.join
  end

  def pluralise_lives
    @game.lives_left == 1 ? "1 life" : "#{@game.lives_left} lives"
  end

  def display_word
    puts "The word was #{@game.word}"
  end
end
