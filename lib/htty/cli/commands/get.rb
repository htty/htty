require 'htty'

# Encapsulates the _get_ command.
class HTTY::CLI::Commands::Get < HTTY::CLI::Command

  # Returns the command that the _get_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpGet
  end

end
