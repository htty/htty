require 'htty'

# Encapsulates the _http-options_ command.
class HTTY::CLI::Commands::HttpOptions < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-options_ command.
  def self.help
    'Issues an HTTP OPTIONS using the current request'
  end

  # Returns the extended help text for the _http-options_ command.
  def self.help_extended
    "Issues an HTTP OPTIONS using the current request.\n"                    +
    "\n"                                                                     +
    'Any request body you may set is ignored (i.e., it is not sent as part ' +
    'of the request).'
  end

  # Returns related command classes for the _http-options_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HttpGet]
  end

end
