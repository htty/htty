# Defines HTTY::CLI::Commands::SchemeSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/port_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _scheme-set_ command.
class HTTY::CLI::Commands::SchemeSet < HTTY::CLI::Command

  # Returns the name of a category under which help for the _scheme-set_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _scheme-set_ command.
  def self.command_line_arguments
    'scheme'
  end

  # Returns the help text for the _scheme-set_ command.
  def self.help
    "Changes the scheme (protocol identifier) of the request's address"
  end

  # Returns the extended help text for the _scheme-set_ command.
  def self.help_extended
    'Changes the scheme, or protocol identifier, used for the request. Does ' +
    "not communicate with the endpoint.\n"                                    +
    "\n"                                                                      +
    "The scheme you supply must be either 'http' or 'https'. Changing the "   +
    "scheme has no effect on the port, and vice versa.\n"                     +
    "\n"                                                                      +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _scheme-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Address, HTTY::CLI::Commands::PortSet]
  end

  # Initializes a new HTTY::CLI::SchemeSet with attribute values specified in
  # the _attributes_ hash.
  #
  # Valid _attributes_ keys include:
  #
  # * <tt>:arguments</tt>
  # * <tt>:session</tt>
  def initialize(attributes={})
    super attributes
    @arguments.collect! do |a|
      a.gsub(/:\/\/$/, '')
    end
  end

  # Performs the _scheme-set_ command.
  def perform
    add_request_if_has_response do |request|
      request.scheme_set(*arguments)
    end
  end

end
