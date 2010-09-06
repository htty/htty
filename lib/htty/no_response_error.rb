# Defines HTTY::NoResponseError.

module HTTY; end

# Indicates that HTTY::Request#response was missing.
class HTTY::NoResponseError < StandardError

  def initialize
    super 'request does not have a response'
  end

end
