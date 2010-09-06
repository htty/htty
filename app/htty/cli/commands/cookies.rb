# Defines HTTY::CLI::Commands::Cookies.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies_add")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove_all")
require File.expand_path("#{File.dirname __FILE__}/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/headers_request")
require File.expand_path("#{File.dirname __FILE__}/headers_response")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookies_ command.
class HTTY::CLI::Commands::Cookies < HTTY::CLI::Command

  # Returns the name of a category under which help for the _cookies_ command
  # should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _cookies_ command.
  def self.help
    'Displays the cookies of the request'
  end

  # Returns the extended help text for the _cookies_ command.
  def self.help_extended
    'Displays the cookies used for the request. Does not communicate with '   +
    "the endpoint.\n"                                                         +
    "\n"                                                                      +
    "This command displays cookies extracted from the request's 'Cookie' "    +
    "header, which is nevertheless shown when you type 'headers-request'.\n"  +
    "\n"                                                                      +
    'Cookies are not required to have unique names. You can add multiple '    +
    'cookies with the same name, and they will be removed in '                +
    "last-in-first-out order.\n"                                              +
    "\n"                                                                      +
    'Cookies are cleared automatically when you change hosts.'
  end

  # Returns related command classes for the _cookies_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::CookiesAdd,
     HTTY::CLI::Commands::CookiesRemove,
     HTTY::CLI::Commands::CookiesRemoveAll,
     HTTY::CLI::Commands::CookiesUse,
     HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::HeadersResponse]
  end

  # Performs the _cookies_ command.
  def perform
    cookies = session.requests.last.cookies
    margin = cookies.inject 0 do |result, cookie|
      [cookie.first.length, result].max
    end
    cookies.each do |name, value|
      puts "#{name.rjust margin}: #{value}"
    end
    self
  end

end
