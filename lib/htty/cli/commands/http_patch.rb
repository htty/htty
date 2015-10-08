require 'htty'

# Encapsulates the _http-patch_ command.
class HTTY::CLI::Commands::HttpPatch < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-patch_ command.
  def self.help
    'Issues an HTTP PATCH using the current request'
  end

  # Returns related command classes for the _http-patch_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HttpGet,
     HTTY::CLI::Commands::Follow,
     HTTY::CLI::Commands::HttpPost,
     HTTY::CLI::Commands::HttpPut,
     HTTY::CLI::Commands::HttpDelete]
  end

end
