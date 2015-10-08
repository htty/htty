require 'htty'

# Encapsulates the _query-clear_ command.
class HTTY::CLI::Commands::QueryClear < HTTY::CLI::Command

  # Returns the command that the _query-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::QueryUnsetAll
  end

end
