require 'htty'

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
    'host.'
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
    add_request_if_new do |request|
      request.cookies_remove_all(*arguments)
    end
  end

end
