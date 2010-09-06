# Defines HTTY::CLI::Commands::QueryClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/query_unset_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _query-clear_ command.
class HTTY::CLI::Commands::QueryClear < HTTY::CLI::Command

  # Returns the command that the _query-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::QueryUnsetAll
  end

end
