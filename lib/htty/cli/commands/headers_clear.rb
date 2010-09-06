# Defines HTTY::CLI::Commands::HeadersClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/headers_unset_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _headers-clear_ command.
class HTTY::CLI::Commands::HeadersClear < HTTY::CLI::Command

  # Returns the command that the _headers-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersUnsetAll
  end

end
