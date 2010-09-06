# Defines HTTY::CLI::Commands::HttpPost.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../http_method_command")
require File.expand_path("#{File.dirname __FILE__}/follow")
require File.expand_path("#{File.dirname __FILE__}/http_delete")
require File.expand_path("#{File.dirname __FILE__}/http_get")
require File.expand_path("#{File.dirname __FILE__}/http_put")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _http-post_ command.
class HTTY::CLI::Commands::HttpPost < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-post_ command.
  def self.help
    'Issues an HTTP POST using the current request'
  end

  # Returns related command classes for the _http-post_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HttpGet,
     HTTY::CLI::Commands::Follow,
     HTTY::CLI::Commands::HttpPut,
     HTTY::CLI::Commands::HttpDelete]
  end

end
