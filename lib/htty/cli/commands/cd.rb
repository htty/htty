require 'htty'

# Encapsulates the _cd_ command.
class HTTY::CLI::Commands::Cd < HTTY::CLI::Command

  # Returns the command that the _cd_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::PathSet
  end

end
