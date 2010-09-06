# Defines HTTY::CLI::Commands::Delete.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/http_delete")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _delete_ command.
class HTTY::CLI::Commands::Delete < HTTY::CLI::Command

  # Returns the command that the _delete_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpDelete
  end

end
