# Defines HTTY::CLI::Commands::QueryUnsetAll.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/query_set")
require File.expand_path("#{File.dirname __FILE__}/query_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _query-unset-all_ command.
class HTTY::CLI::Commands::QueryUnsetAll < HTTY::CLI::Command

  # Returns the name of a category under which help for the _query-unset-all_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _query-unset-all_ command.
  def self.help
    "Clears the query string of the request's address"
  end

  # Returns the extended help text for the _query-unset-all_ command.
  def self.help_extended
    'Clears the query string used for the request. Does not communicate with ' +
    "the endpoint.\n"                                                          +
    "\n"                                                                       +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _query-unset-all_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::QueryUnset,
     HTTY::CLI::Commands::QuerySet,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _query-unset-all_ command.
  def perform
    add_request_if_has_response do |request|
      request.query_unset_all(*arguments)
    end
  end

end
