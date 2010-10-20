module HTTY; end

# Encapsulates _htty_ user preferences.
class HTTY::Preferences

  # Returns the instance of HTTY::Preferences holding current preferences.
  def self.current
    @current ||= new
  end

end
