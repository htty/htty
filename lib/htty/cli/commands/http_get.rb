# Defines HTTY::CLI::Commands::HttpGet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../http_method_command")
require File.expand_path("#{File.dirname __FILE__}/follow")
require File.expand_path("#{File.dirname __FILE__}/http_delete")
require File.expand_path("#{File.dirname __FILE__}/http_post")
require File.expand_path("#{File.dirname __FILE__}/http_put")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _http-get_ command.
class HTTY::CLI::Commands::HttpGet < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-get_ command.
  def self.help
    'Issues an HTTP GET using the current request'
  end

  # Returns the extended help text for the _http-get_ command.
  def self.help_extended
    "Issues an HTTP GET using the current request.\n"                        +
    "\n"                                                                     +
    'Any request body you may set is ignored (i.e., it is not sent as part ' +
    'of the request).'
  end

  # Returns related command classes for the _http-get_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Follow,
     HTTY::CLI::Commands::HttpPost,
     HTTY::CLI::Commands::HttpPut,
     HTTY::CLI::Commands::HttpDelete]
  end

end
