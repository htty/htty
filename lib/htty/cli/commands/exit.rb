# Defines HTTY::CLI::Commands::Exit.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/quit")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _exit_ command.
class HTTY::CLI::Commands::Exit < HTTY::CLI::Command

  # Returns the command that the _exit_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::Quit
  end

end
