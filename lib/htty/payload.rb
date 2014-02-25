require File.expand_path("#{File.dirname __FILE__}/headers")
require File.expand_path("#{File.dirname __FILE__}/no_header_error")
require File.expand_path("#{File.dirname __FILE__}/cookies_util")

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

  def headers_with_key(key)
    headers.select do |header_key, header_value|
      key.downcase == header_key.downcase
    end
  end

  def header(key, otherwise=:__no_default_value_given)
    all_headers_with_key = headers_with_key(key)
    return all_headers_with_key.last.last unless all_headers_with_key.empty?
    raise otherwise if otherwise.is_a? Exception
    return otherwise unless otherwise == :__no_default_value_given
    raise HTTY::NoHeaderError.new(key)
  end

  def cookies_from(cookies_header_key)
    HTTY::CookiesUtil.cookies_from_string header(cookies_header_key, nil)
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
    @headers = HTTY::Headers.new
    Array(attributes[:headers]).each do |name, value|
      @headers[name] = value
    end
  end

end
