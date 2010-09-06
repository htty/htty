# Defines HTTY::CLI::Commands::CookiesRemoveAll.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies")
require File.expand_path("#{File.dirname __FILE__}/cookies_add")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove")
require File.expand_path("#{File.dirname __FILE__}/cookies_use")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookies-remove-all_ command.
class HTTY::CLI::Commands::CookiesRemoveAll < HTTY::CLI::Command

  # Returns the name of a category under which help for the _cookies-remove-all_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _cookies-remove-all_ command.
  def self.help
    'Removes all cookies from the request'
  end

  # Returns the extended help text for the _cookies-remove-all_ command.
  def self.help_extended
    'Removes all cookies used for the request. Does not communicate with the ' +
    'endpoint.'
  end

  # Returns related command classes for the _cookies-remove-all_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Cookies,
     HTTY::CLI::Commands::CookiesRemove,
     HTTY::CLI::Commands::CookiesAdd,
     HTTY::CLI::Commands::CookiesUse]
  end

  # Performs the _cookies-remove-all_ command.
  def perform
    add_request_if_has_response do |request|
      request.cookies_remove_all(*arguments)
    end
  end

end
