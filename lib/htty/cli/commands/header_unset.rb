# Defines HTTY::CLI::Commands::HeaderUnset.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/headers_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _header-unset_ command.
class HTTY::CLI::Commands::HeaderUnset < HTTY::CLI::Command

  # Returns the command that the _header-unset_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HeadersUnset
  end

end
