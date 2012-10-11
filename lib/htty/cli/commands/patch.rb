require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/http_patch")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _patch_ command.
class HTTY::CLI::Commands::Patch < HTTY::CLI::Command

  # Returns the command that the _patch_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPatch
  end

end
