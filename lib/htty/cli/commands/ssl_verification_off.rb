require 'htty'

# Encapsulates the _ssl-verification-off_ command.
class HTTY::CLI::Commands::SslVerificationOff < HTTY::CLI::Command

  # Returns the name of a category under which help for the
  # _ssl-verification-off_ command should appear.
  def self.category
    'Preferences'
  end

  # Returns the help text for the _ssl-verification-off_ command.
  def self.help
    'Disables SSL certificate verification'
  end

  # Returns the extended help text for the _ssl-verification-off_ command.
  def self.help_extended
    'Disables SSL certificate verification. Does not communicate with the host.'
  end

  # Returns related command classes for the _ssl-verification-off_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::SslVerificationOn,
     HTTY::CLI::Commands::SslVerification]
  end

  # Performs the _ssl-verification-off_ command.
  def perform
    HTTY::Preferences.current.verify_certificates = false
  end

end
