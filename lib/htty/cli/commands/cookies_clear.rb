require 'htty'

# Encapsulates the _cookies-clear_ command.
class HTTY::CLI::Commands::CookiesClear < HTTY::CLI::Command

  # Returns the command that the _cookies-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesRemoveAll
  end

end
