require File.expand_path("#{File.dirname __FILE__}/../../preferences")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/ssl_verification")
require File.expand_path("#{File.dirname __FILE__}/ssl_verification_off")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _ssl-verification-on_ command.
class HTTY::CLI::Commands::SslVerificationOn < HTTY::CLI::Command

  # Returns the name of a category under which help for the
  # _ssl-verification-on_ command should appear.
  def self.category
    'Preferences'
  end

  # Returns the help text for the _ssl-verification-on_ command.
  def self.help
    'Reenables SSL certificate verification'
  end

  # Returns the extended help text for the _ssl-verification-on_ command.
  def self.help_extended
    'Reenables SSL certificate verification. Does not communicate with the ' +
    'host.'
  end

  # Returns related command classes for the _ssl-verification-on_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::SslVerificationOff,
     HTTY::CLI::Commands::SslVerification]
  end

  # Performs the _ssl-verification-on_ command.
  def perform
    HTTY::Preferences.current.verify_certificates = true
  end

end
