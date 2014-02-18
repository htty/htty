require File.expand_path("#{File.dirname __FILE__}/../../request")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/userinfo_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _userinfo-set_ command.
class HTTY::CLI::Commands::UserinfoSet < HTTY::CLI::Command

  extend HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _userinfo-set_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _userinfo-set_
  # command.
  def self.command_line_arguments
    'USERNAME [PASSWORD]'
  end

  # Returns the help text for the _userinfo-set_ command.
  def self.help
    "Sets the userinfo of the request's address"
  end

  # Returns the extended help text for the _userinfo-set_ command.
  def self.help_extended
    'Sets the userinfo used for the request. Does not communicate with the '   +
    "host.\n"                                                                  +
    "\n"                                                                       +
    "Userinfo will be URL-encoded if necessary.\n"                             +
    "\n"                                                                       +
    'When userinfo is set, a corresponding '                                   +
    "'#{HTTY::Request::AUTHORIZATION_HEADER_NAME}' header is set "             +
    "automatically.\n"                                                         +
    "\n"                                                                       +
    'The console prompt shows the address for the current request. Userinfo '  +
    'appears in normal type while the rest of the address appears in bold to ' +
    'indicate that userinfo is sent to the host in the form of a header.'
  end

  # Returns related command classes for the _userinfo-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::UserinfoUnset, HTTY::CLI::Commands::Address]
  end

  def self.sanitize_arguments(arguments)
    if (arguments.length == 1) && (arguments.first.scan(':').length == 1)
      arguments = arguments.first.split(':')
    end
    escape_or_warn_of_escape_sequences(arguments)
  end

  # Performs the _userinfo-set_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        request.userinfo_set(*arguments)
      end
    end
  end

end
