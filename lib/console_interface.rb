class ConsoleInterface
  def display_output(output)
    puts(output.to_s)
  end

  def get_input
    readline.chomp
  end
end
