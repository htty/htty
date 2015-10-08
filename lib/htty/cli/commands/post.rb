require 'htty'

# Encapsulates the _post_ command.
class HTTY::CLI::Commands::Post < HTTY::CLI::Command

  # Returns the command that the _post_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPost
  end

end
