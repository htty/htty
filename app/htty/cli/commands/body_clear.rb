# Defines HTTY::CLI::Commands::BodyClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-clear_ command.
class HTTY::CLI::Commands::BodyClear < HTTY::CLI::Command

  # Returns the command that the _body-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::BodyUnset
  end

end
