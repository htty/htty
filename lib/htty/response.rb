# Defines HTTY::Response.

require File.expand_path("#{File.dirname __FILE__}/cookies_util")
require File.expand_path("#{File.dirname __FILE__}/payload")

module HTTY; end

# Encapsulates an HTTP(S) response.
class HTTY::Response < HTTY::Payload

  COOKIES_HEADER_NAME = 'Set-Cookie'

  # Returns the HTTP status associated with the response.
  attr_reader :status

  # Initializes a new HTTY::Response with attribute values specified in the
  # _attributes_ hash.
  #
  # Valid _attributes_ keys include:
  #
  # * <tt>:body</tt>
  # * <tt>:headers</tt>
  # * <tt>:status</tt>
  def initialize(attributes={})
    super attributes
    @status = attributes[:status]
  end

  # Returns an array of the cookies belonging to the response.
  def cookies
    HTTY::CookiesUtil.cookies_from_string @headers[COOKIES_HEADER_NAME]
  end

end
