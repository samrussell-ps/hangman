class ConsoleInterface
  # command
  def display_output(output)
    puts(output.to_s)
  end

  # query
  def get_input
    readline.chomp
  end
end
