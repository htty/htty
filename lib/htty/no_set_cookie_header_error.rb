# Defines HTTY::NoSetCookieHeaderError.

module HTTY; end

# Indicates that the _Set-Cookie_ header was missing from
# HTTY::Request#response.
class HTTY::NoSetCookieHeaderError < StandardError

  def initialize
    super "response does not have a 'Set-Cookie' header"
  end

end
