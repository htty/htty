require 'htty'

# Encapsulates the _query-add_ command.
class HTTY::CLI::Commands::QueryAdd < HTTY::CLI::Command

  include HTTY::CLI::Display
  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _query-add_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _query-add_ command.
  def self.command_line_arguments
    'NAME [VALUE [NAME [VALUE ...]]]'
  end

  # Returns the help text for the _query-add_ command.
  def self.help
    "Adds query-string parameters to the request's address"
  end

  # Returns the extended help text for the _query-add_ command.
  def self.help_extended
    'Adds one or more query-string parameters used for the request. Does not ' +
    "communicate with the host.\n"                                             +
    "\n"                                                                       +
    'The difference between this command and '                                 +
    "#{strong HTTY::CLI::Commands::QuerySet.command_line} is that this "       +
    "command adds duplicate parameters instead of replacing any of them.\n"    +
    "\n"                                                                       +
    'The name(s) and value(s) of the query-string parameter(s) will be URL-'   +
    "encoded if necessary.\n"                                                  +
    "\n"                                                                       +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _query-add_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::QueryRemove,
     HTTY::CLI::Commands::QuerySet,
     HTTY::CLI::Commands::QueryUnset,
     HTTY::CLI::Commands::QueryUnsetAll,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _query-add_ command.
  def perform
    if arguments.empty?
      raise ArgumentError, 'wrong number of arguments (0 for N)'
    end

    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        escaped_arguments = escape_or_warn_of_escape_sequences(arguments)
        escaped_arguments.each_slice 2 do |name, value|
          request = request.query_add(name, value)
        end
        request
      end
    end
  end

end
