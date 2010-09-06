# Defines HTTY::CLI::Commands::HostSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../cookie_clearing_command")
require File.expand_path("#{File.dirname __FILE__}/address")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _host-set_ command.
class HTTY::CLI::Commands::HostSet < HTTY::CLI::Command

  include HTTY::CLI::CookieClearingCommand

  # Returns the name of a category under which help for the _host-set_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _host-set_ command.
  def self.command_line_arguments
    'host'
  end

  # Returns the help text for the _host-set_ command.
  def self.help
    "Changes the host of the request's address"
  end

  # Returns the extended help text for the _host-set_ command.
  def self.help_extended
    'Changes the host used for the request. Does not communicate with the '  +
    "endpoint.\n"                                                            +
    "\n"                                                                     +
    "The host you supply can be either a hostname (e.g., 'github.com') or "  +
    "an IP address (e.g., '127.0.0.1').\n"                                   +
    "\n"                                                                     +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _host-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Address]
  end

  # Performs the _host-set_ command.
  def perform
    add_request_if_has_response do |request|
      notify_if_cookies_cleared request do
        request.host_set(*arguments)
      end
    end
  end

end
