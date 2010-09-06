# Defines HTTY::CLI::Commands::Post.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/http_post")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _post_ command.
class HTTY::CLI::Commands::Post < HTTY::CLI::Command

  # Returns the command that the _post_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::HttpPost
  end

end
