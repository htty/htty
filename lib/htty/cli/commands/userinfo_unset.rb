require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/userinfo_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _userinfo-unset_ command.
class HTTY::CLI::Commands::UserinfoUnset < HTTY::CLI::Command

  # Returns the name of a category under which help for the _userinfo-unset_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _userinfo-unset_ command.
  def self.help
    "Removes the userinfo from the request's address"
  end

  # Returns the extended help text for the _userinfo-unset_ command.
  def self.help_extended
    'Removes the userinfo used for the request. Does not communicate with ' +
    "the host.\n"                                                           +
    "\n"                                                                    +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _userinfo-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::UserinfoSet, HTTY::CLI::Commands::Address]
  end

  # Performs the _userinfo-unset_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        request.userinfo_unset(*arguments)
      end
    end
  end

end
