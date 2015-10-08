require 'htty'

# Encapsulates the _query-unset_ command.
class HTTY::CLI::Commands::QueryUnset < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _query-unset_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _query-unset_
  # command.
  def self.command_line_arguments
    'NAME [VALUE]'
  end

  # Returns the help text for the _query-unset_ command.
  def self.help
    "Removes query-string parameters from the request's address"
  end

  # Returns the extended help text for the _query-unset_ command.
  def self.help_extended
    'Removes one or more a query-string parameters used for the request. '     +
    "Does not communicate with the host.\n"                                    +
    "\n"                                                                       +
    'The difference between this command and '                                 +
    "#{strong HTTY::CLI::Commands::QueryRemove.command_line} is that this "    +
    'command removes all matching parameters instead of removing matches one ' +
    "at a time from the end of the address.\n"                                 +
    "\n"                                                                       +
    'The name of the query-string parameter will be URL-encoded if '           +
    "necessary.\n"                                                             +
    "\n"                                                                       +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _query-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::QuerySet,
     HTTY::CLI::Commands::QueryUnsetAll,
     HTTY::CLI::Commands::QueryAdd,
     HTTY::CLI::Commands::QueryRemove,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _query-unset_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        unset_method = (arguments.length == 2) ? :query_remove : :query_unset
        request.send(unset_method,
                     *escape_or_warn_of_escape_sequences(arguments))
      end
    end
  end

end
