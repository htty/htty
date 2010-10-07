module HTTY; end

# Encapsulates _htty_ user preferences.
class HTTY::Preferences

  # Returns the instance of HTTY::Preferences holding current preferences.
  def self.current
    @current ||= new
  end

  # Sets the boolean preference for whether server certificates are verified
  # during HTTP Secure requests.
  attr_writer :verify_certificates

  # Initializes a new HTTY::Preferences object.
  def initialize
    @verify_certificates = true
  end

  # Returns +true+ if server certificates are verified during HTTP Secure
  # requests.
  def verify_certificates?
    @verify_certificates
  end

end
