# Defines HTTY::CLI::Commands::HttpHead.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../http_method_command")
require File.expand_path("#{File.dirname __FILE__}/http_get")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _http-head_ command.
class HTTY::CLI::Commands::HttpHead < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-head_ command.
  def self.help
    'Issues an HTTP HEAD using the current request'
  end

  # Returns the extended help text for the _http-head_ command.
  def self.help_extended
    "Issues an HTTP HEAD using the current request.\n"                        +
    "\n"                                                                     +
    'Any request body you may set is ignored (i.e., it is not sent as part ' +
    'of the request).'
  end

  # Returns related command classes for the _http-head_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HttpGet]
  end

end
