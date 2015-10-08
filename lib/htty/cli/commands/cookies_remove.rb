require 'htty'

# Encapsulates the _cookies-remove_ command.
class HTTY::CLI::Commands::CookiesRemove < HTTY::CLI::Command

  # Returns the name of a category under which help for the _cookies-remove_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the arguments for the command-line usage of the _cookies-remove_
  # command.
  def self.command_line_arguments
    'NAME'
  end

  # Returns the help text for the _cookies-remove_ command.
  def self.help
    'Removes from the request the last cookie having a particular name'
  end

  # Returns the extended help text for the _cookies-remove_ command.
  def self.help_extended
    'Removes a cookie used for the request. Does not communicate with the ' +
    "host.\n"                                                               +
    "\n"                                                                    +
    'Cookies are not required to have unique names. You can add multiple '  +
    'cookies with the same name, and they will be removed in '              +
    'last-in-first-out order.'
  end

  # Returns related command classes for the _cookies-remove_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Cookies,
     HTTY::CLI::Commands::CookiesAdd,
     HTTY::CLI::Commands::CookiesRemoveAll,
     HTTY::CLI::Commands::CookiesUse]
  end

  # Performs the _cookies-remove_ command.
  def perform
    add_request_if_new do |request|
      request.cookie_remove(*arguments)
    end
  end

end
