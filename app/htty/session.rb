# Defines HTTY::Session.

require File.expand_path("#{File.dirname __FILE__}/request")

module HTTY; end

# Encapsulates an _htty_ session.
class HTTY::Session

  # Returns the requests made during the session.
  attr_reader :requests

  # Initializes a new HTTY::Session with specified _address_ for the first of
  # the session's #requests.
  def initialize(address)
    @requests = [HTTY::Request.new(address)]
  end

  # Walks #requests and returns its last HTTY::Response.
  def last_response
    last_request_with_response = requests.reverse.detect do |r|
      r.response
    end
    return nil unless last_request_with_response

    last_request_with_response.response
  end

end
