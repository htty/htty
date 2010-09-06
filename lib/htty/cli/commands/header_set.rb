# Defines HTTY::CLI::Commands::HeaderSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/headers_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _header-set_ command.
class HTTY::CLI::Commands::HeaderSet < HTTY::CLI::Command

  # Returns the command that the _header-set_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersSet
  end

end
