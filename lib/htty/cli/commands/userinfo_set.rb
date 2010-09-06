# Defines HTTY::CLI::Commands::UserinfoSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/userinfo_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _userinfo-set_ command.
class HTTY::CLI::Commands::UserinfoSet < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _userinfo-set_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _userinfo-set_
  # command.
  def self.command_line_arguments
    'userinfo'
  end

  # Returns the help text for the _userinfo-set_ command.
  def self.help
    "Sets the userinfo of the request's address"
  end

  # Returns the extended help text for the _userinfo-set_ command.
  def self.help_extended
    'Sets the userinfo used for the request. Does not communicate with the ' +
    "endpoint.\n"                                                            +
    "\n"                                                                     +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _userinfo-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::UserinfoUnset, HTTY::CLI::Commands::Address]
  end

  # Performs the _userinfo-set_ command.
  def perform
    add_request_if_has_response do |request|
      request.userinfo_set(*escape_or_warn_of_escape_sequences(arguments))
    end
  end

end
