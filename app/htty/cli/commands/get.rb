# Defines HTTY::CLI::Commands::Get.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/http_get")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _get_ command.
class HTTY::CLI::Commands::Get < HTTY::CLI::Command

  # Returns the command that the _get_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpGet
  end

end
