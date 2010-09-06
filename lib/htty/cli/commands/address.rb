# Defines HTTY::CLI::Commands::Address.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../cookie_clearing_command")
require File.expand_path("#{File.dirname __FILE__}/port_set")
require File.expand_path("#{File.dirname __FILE__}/scheme_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _address_ command.
class HTTY::CLI::Commands::Address < HTTY::CLI::Command

  include HTTY::CLI::CookieClearingCommand

  # Returns the name of a category under which help for the _address_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _address_ command.
  def self.command_line_arguments
    'address'
  end

  # Returns the help text for the _address_ command.
  def self.help
    'Changes the address of the request'
  end

  # Returns the extended help text for the _address_ command.
  def self.help_extended
    'Changes the address used for the request. Does not communicate with the ' +
    "endpoint.\n"                                                              +
    "\n"                                                                       +
    'The URL you supply can be partial. At a minimum, you must specify a '     +
    'host. The optional and required elements of an address are illustrated '  +
    "below:\n"                                                                 +
    "\n"                                                                       +
    "https://steve:woodside@apple.com:6666/store?q=ipad#sold-to-date\n"        +
    "\\______/\\_____________/\\_______/\\___/\\____/\\_____/\\___________/\n" +
    "   1.          2.          3.     4.   5.     6.        7.\n"             +
    "\n"                                                                       +
    "1. A scheme, or protocol identifier (i.e., 'http://' or 'https://' -- "   +
    "optional)\n"                                                              +
    "2. Userinfo (e.g., 'username:password@' -- optional)\n"                   +
    "3. A host (i.e., a hostname or IP address -- required)\n"                 +
    "4. A TCP port number (i.e., ':0' through ':65535' -- optional)\n"         +
    "5. A path (optional)\n"                                                   +
    "6. A query string (e.g., '?foo=bar&baz=qux' -- optional)\n"               +
    "7. A fragment (e.g., '#fragment-name' -- optional)\n"                     +
    "\n"                                                                       +
    'If (1) is omitted, HTTP is used, except if (4) is specified as port '     +
    "443, in which case HTTPS is used.\n"                                      +
    "\n"                                                                       +
    "If (3) is omitted, host 0.0.0.0 is used.\n"                               +
    "\n"                                                                       +
    'If (4) is omitted, port 80 is used, except if (1) is specified as '       +
    "HTTPS, in which case port 443 is used.\n"                                 +
    "\n"                                                                       +
    "If (5) is omitted, the root path (i.e., \"/\") is used.\n"                +
    "\n"                                                                       +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _address_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::SchemeSet, HTTY::CLI::Commands::PortSet]
  end

  # Performs the _address_ command.
  def perform
    add_request_if_has_response do |request|
      notify_if_cookies_cleared request do
        request.address(*arguments)
      end
    end
  end

end
