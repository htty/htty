# Defines HTTY::CLI::Commands::Cd.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/path_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cd_ command.
class HTTY::CLI::Commands::Cd < HTTY::CLI::Command

  # Returns the command that the _cd_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::PathSet
  end

end
