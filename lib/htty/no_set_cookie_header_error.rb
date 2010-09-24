require File.expand_path("#{File.dirname __FILE__}/response")

module HTTY; end

# Indicates that the _Set-Cookie_ header was missing from
# HTTY::Request#response.
class HTTY::NoSetCookieHeaderError < StandardError

  def initialize
    super "response does not have a '#{HTTY::Response::COOKIES_HEADER_NAME}' " +
          'header'
  end

end
