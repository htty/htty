require 'htty'

# Encapsulates the _http-put_ command.
class HTTY::CLI::Commands::HttpPut < HTTY::CLI::Command

  include HTTY::CLI::HTTPMethodCommand

  # Returns the help text for the _http-put_ command.
  def self.help
    'Issues an HTTP PUT using the current request'
  end

  # Returns related command classes for the _http-put_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HttpGet,
     HTTY::CLI::Commands::HttpPatch,
     HTTY::CLI::Commands::HttpPost,
     HTTY::CLI::Commands::HttpDelete]
  end

end
