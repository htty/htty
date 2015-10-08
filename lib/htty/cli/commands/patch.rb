require 'htty'

# Encapsulates the _patch_ command.
class HTTY::CLI::Commands::Patch < HTTY::CLI::Command

  # Returns the command that the _patch_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPatch
  end

end
