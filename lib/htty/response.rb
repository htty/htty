require File.expand_path("#{File.dirname __FILE__}/cookies_util")
require File.expand_path("#{File.dirname __FILE__}/payload")

module HTTY; end

# Encapsulates an HTTP(S) response.
class HTTY::Response < HTTY::Payload

  COOKIES_HEADER_NAME  = 'Set-Cookie'
  LOCATION_HEADER_NAME = 'Location'

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
    @already_followed = false
  end

  # Returns an array of the cookies belonging to the response.
  def cookies
    cookies_from(COOKIES_HEADER_NAME)
  end

  def follow_relative_to(request)
    return request if @already_followed
    location_uri = URI.parse(location_header = location)
    if location_uri.absolute?
      request.address location_header
    else
      request.
        path_set(location_uri.path).
        query_set_all(location_uri.query).
        fragment_set(location_uri.fragment)
    end
  ensure
    @already_followed = true
  end

  def location
    header(LOCATION_HEADER_NAME, HTTY::NoLocationHeaderError.new)
  end
end
