require 'htty'

# Encapsulates the _header-set_ command.
class HTTY::CLI::Commands::HeaderSet < HTTY::CLI::Command

  # Returns the command that the _header-set_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersSet
  end

end
