require 'htty'

# Encapsulates the _cookie-remove_ command.
class HTTY::CLI::Commands::CookieRemove < HTTY::CLI::Command

  # Returns the command that the _cookie-remove_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesRemove
  end

end
