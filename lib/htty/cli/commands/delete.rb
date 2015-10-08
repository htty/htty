require 'htty'

# Encapsulates the _delete_ command.
class HTTY::CLI::Commands::Delete < HTTY::CLI::Command

  # Returns the command that the _delete_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpDelete
  end

end
