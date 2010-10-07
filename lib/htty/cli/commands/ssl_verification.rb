require File.expand_path("#{File.dirname __FILE__}/../../preferences")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/ssl_verification_off")
require File.expand_path("#{File.dirname __FILE__}/ssl_verification_on")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _ssl-verification_ command.
class HTTY::CLI::Commands::SslVerification < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _ssl-verification_
  # command should appear.
  def self.category
    'Preferences'
  end

  # Returns the help text for the _ssl-verification_ command.
  def self.help
    'Displays the preference for SSL certificate verification'
  end

  # Returns the extended help text for the _ssl-verification_ command.
  def self.help_extended
    'Displays the preference for SSL certificate verification. Does not ' +
    "communicate with the host.\n"                                        +
    "\n"                                                                  +
    'When issuing HTTP Secure requests, server certificates will be '     +
    'verified. You can disable and reenable this behavior.'
  end

  # Returns related command classes for the _ssl-verification_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::SslVerificationOff,
     HTTY::CLI::Commands::SslVerificationOn]
  end

  # Performs the _ssl-verification_ command.
  def perform
    unless arguments.empty?
      raise ArgumentError,
            "wrong number of arguments (#{arguments.length} for 0)"
    end

    will_or_not = HTTY::Preferences.current.verify_certificates? ?
                  'will'                                         :
                  'will not'
    puts notice("SSL certificates #{will_or_not} be verified")
  end

end
