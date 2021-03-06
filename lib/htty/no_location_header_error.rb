require 'htty'

# Indicates that the _Location_ header was missing from HTTY::Request#response.
class HTTY::NoLocationHeaderError < StandardError

  def initialize
    super 'response does not have a ' +
          "'#{HTTY::Response::LOCATION_HEADER_NAME}' header"
  end

end
