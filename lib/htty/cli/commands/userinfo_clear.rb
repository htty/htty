require 'htty'

# Encapsulates the _userinfo-clear_ command.
class HTTY::CLI::Commands::UserinfoClear < HTTY::CLI::Command

  # Returns the command that the _userinfo-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::UserinfoUnset
  end

end
