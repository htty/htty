# Defines HTTY::CLI::Commands::CookieRemove.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookie-remove_ command.
class HTTY::CLI::Commands::CookieRemove < HTTY::CLI::Command

  # Returns the command that the _cookie-remove_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesRemove
  end

end
