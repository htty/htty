# Defines HTTY::CLI::Commands::CookiesClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookies-clear_ command.
class HTTY::CLI::Commands::CookiesClear < HTTY::CLI::Command

  # Returns the command that the _cookies-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::CookiesRemoveAll
  end

end
