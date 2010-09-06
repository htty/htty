# Defines HTTY::CLI::Commands::Put.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/http_put")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _put_ command.
class HTTY::CLI::Commands::Put < HTTY::CLI::Command

  # Returns the command that the _put_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPut
  end

end
