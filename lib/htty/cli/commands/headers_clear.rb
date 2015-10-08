require 'htty'

# Encapsulates the _headers-clear_ command.
class HTTY::CLI::Commands::HeadersClear < HTTY::CLI::Command

  # Returns the command that the _headers-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersUnsetAll
  end

end
