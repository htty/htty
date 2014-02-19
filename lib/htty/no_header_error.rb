module HTTY; end

# Indicates that an header could not be found in a HTTY::Payload
class HTTY::NoHeaderError < StandardError

  def initialize(key)
    super "header #{key} not found"
  end

end
