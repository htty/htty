require 'htty'

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
     HTTY::CLI::Commands::HttpPatch,
     HTTY::CLI::Commands::HttpPost,
     HTTY::CLI::Commands::HttpPut,
     HTTY::CLI::Commands::HttpDelete]
  end

end
