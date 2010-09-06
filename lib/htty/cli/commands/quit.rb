# Defines HTTY::CLI::Commands::Quit.

require File.expand_path("#{File.dirname __FILE__}/../command")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

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
