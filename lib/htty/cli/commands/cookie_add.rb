require 'htty'

# Encapsulates the _cookie-add_ command.
class HTTY::CLI::Commands::CookieAdd < HTTY::CLI::Command

  # Returns the command that the _cookie-add_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesAdd
  end

end
