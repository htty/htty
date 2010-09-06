# Defines HTTY::CLI::Commands::FragmentClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/fragment_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _fragment-clear_ command.
class HTTY::CLI::Commands::FragmentClear < HTTY::CLI::Command

  # Returns the command that the _fragment-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::FragmentUnset
  end

end
