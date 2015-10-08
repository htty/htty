require 'htty'

# Encapsulates the _body-clear_ command.
class HTTY::CLI::Commands::BodyClear < HTTY::CLI::Command

  # Returns the command that the _body-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::BodyUnset
  end

end
