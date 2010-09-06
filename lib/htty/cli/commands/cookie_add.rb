# Defines HTTY::CLI::Commands::CookieAdd.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies_add")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookie-add_ command.
class HTTY::CLI::Commands::CookieAdd < HTTY::CLI::Command

  # Returns the command that the _cookie-add_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesAdd
  end

end
