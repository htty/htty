# Defines HTTY::Payload.

require File.expand_path("#{File.dirname __FILE__}/ordered_hash")

module HTTY; end

# Encapsulates the headers and body of an HTTP(S) request or response.
class HTTY::Payload

  # Returns the body of the payload.
  attr_reader :body

  # Returns +true+ if _other_payload_ is equivalent to the payload.
  def ==(other_payload)
    return false unless other_payload.kind_of?(HTTY::Payload)
    (other_payload.body == body) && (other_payload.headers == headers)
  end
  alias :eql? :==

  # Returns an array of the headers belonging to the payload.
  def headers
    @headers.to_a
  end

protected

  # Initializes a new HTTY::Payload with attribute values specified in the
  # _attributes_ hash.
  #
  # Valid _attributes_ keys include:
  #
  # * <tt>:body</tt>
  # * <tt>:headers</tt>
  def initialize(attributes={})
    @body    = attributes[:body]
    @headers = HTTY::OrderedHash.new
    Array(attributes[:headers]).each do |name, value|
      @headers[name] = value
    end
  end

  def initialize_copy(source) #:nodoc:
    super
    @body    = @body.dup if @body
    @headers = @headers.dup
  end

end
