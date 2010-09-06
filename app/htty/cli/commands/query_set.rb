# Defines HTTY::CLI::Commands::QuerySet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/query_unset")
require File.expand_path("#{File.dirname __FILE__}/query_unset_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _query-set_ command.
class HTTY::CLI::Commands::QuerySet < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _query-set_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _query-set_
  # command.
  def self.command_line_arguments
    'name value'
  end

  # Returns the help text for the _query-set_ command.
  def self.help
    "Sets a query string parameter in the request's address"
  end

  # Returns the extended help text for the _query-set_ command.
  def self.help_extended
    'Sets a query string parameter used for the request. Does not ' +
    "communicate with the endpoint.\n"                              +
    "\n"                                                            +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _query-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::QueryUnset,
     HTTY::CLI::Commands::QueryUnsetAll,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _query-set_ command.
  def perform
    add_request_if_has_response do |request|
      request.query_set(*escape_or_warn_of_escape_sequences(arguments))
    end
  end

end
