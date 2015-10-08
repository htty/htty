require 'htty'

# Encapsulates the _put_ command.
class HTTY::CLI::Commands::Put < HTTY::CLI::Command

  # Returns the command that the _put_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPut
  end

end
