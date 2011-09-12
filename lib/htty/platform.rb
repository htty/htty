module HTTY; end

# Provides methods for ascertaining system characteristics.
module HTTY::Platform

  def self.windows?
    !(RUBY_PLATFORM =~ /(mswin|mingw)/i).nil?
  end

end
