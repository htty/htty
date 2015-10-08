require 'htty'

# Encapsulates the _header-unset_ command.
class HTTY::CLI::Commands::HeaderUnset < HTTY::CLI::Command

  # Returns the command that the _header-unset_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersUnset
  end

end
