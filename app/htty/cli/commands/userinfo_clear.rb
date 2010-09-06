# Defines HTTY::CLI::Commands::UserinfoClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/userinfo_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _userinfo-clear_ command.
class HTTY::CLI::Commands::UserinfoClear < HTTY::CLI::Command

  # Returns the command that the _userinfo-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::UserinfoUnset
  end

end
