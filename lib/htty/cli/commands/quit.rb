require 'htty'

# Encapsulates the _quit_ command.
class HTTY::CLI::Commands::Quit < HTTY::CLI::Command

  # Returns the help text for the _quit_ command.
  def self.help
    'Quits htty'
  end

  # Performs the _quit_ command.
  def perform
    throw :quit
  end

end
