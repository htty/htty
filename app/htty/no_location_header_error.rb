# Defines HTTY::NoLocationHeaderError.

module HTTY; end

# Indicates that the _Location_ header was missing from HTTY::Request#response.
class HTTY::NoLocationHeaderError < StandardError

  def initialize
    super "response does not have a 'Location' header"
  end

end
