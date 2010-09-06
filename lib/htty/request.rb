# Defines HTTY::Request.

require 'pathname'
require 'uri'
require File.expand_path("#{File.dirname __FILE__}/../htty")
require File.expand_path("#{File.dirname __FILE__}/cookies_util")
require File.expand_path("#{File.dirname __FILE__}/no_location_header_error")
require File.expand_path("#{File.dirname __FILE__}/no_response_error")
require File.expand_path("#{File.dirname __FILE__}/no_set_cookie_header_error")
require File.expand_path("#{File.dirname __FILE__}/payload")
require File.expand_path("#{File.dirname __FILE__}/requests_util")
require File.expand_path("#{File.dirname __FILE__}/response")

module HTTY; end

# Encapsulates an HTTP(S) request.
class HTTY::Request < HTTY::Payload

  COOKIES_HEADER_NAME = 'Cookie'

  METHODS_SENDING_BODY = [:post, :put]

  # Returns a URI authority (a combination of userinfo, host, and port)
  # corresponding to the specified _components_ hash. Valid _components_ keys
  # include:
  #
  # * <tt>:userinfo</tt>
  # * <tt>:host</tt>
  # * <tt>:port</tt>
  def self.build_authority(components)
    userinfo_and_host = [components[:userinfo],
                         components[:host]].compact.join('@')
    all               = [userinfo_and_host, components[:port]].compact.join(':')
    return nil if (all == '')
    all
  end

  # Returns a combination of a URI path, query, and fragment, corresponding to
  # the specified _components_ hash. Valid _components_ keys include:
  #
  # * <tt>:path</tt>
  # * <tt>:query</tt>
  # * <tt>:fragment</tt>
  def self.build_path_query_and_fragment(components)
    path     = components[:path]
    query    = components[:query]    ? "?#{components[:query]}"    : nil
    fragment = components[:fragment] ? "##{components[:fragment]}" : nil
    all      = [path, query, fragment].compact.join
    return nil if (all == '')
    all
  end

  # Returns a URI corresponding to the specified _components_ hash, or raises
  # URI::InvalidURIError. Valid _components_ keys include:
  #
  # * <tt>:scheme</tt>
  # * <tt>:userinfo</tt>
  # * <tt>:host</tt>
  # * <tt>:port</tt>
  # * <tt>:path</tt>
  # * <tt>:query</tt>
  # * <tt>:fragment</tt>
  def self.build_uri(components)
    scheme                  = (components[:scheme] || 'http') + '://'
    authority               = build_authority(components)
    path_query_and_fragment = build_path_query_and_fragment(components)
    path_query_and_fragment ||= '/' if authority
    unless scheme == 'http://'
      raise ArgumentError, "#{scheme.inspect} is not yet supported"
    end
    URI.parse([scheme, authority, path_query_and_fragment].join)
  end

  # Returns a URI corresponding to the specified _address_, or raises
  # URI::InvalidURIError.
  def self.parse_uri(address)
    address = '0.0.0.0' if address.nil? || (address == '')

    scheme_missing = false
    if (address !~ /^[a-z]+:\/\//) && (address !~ /^mailto:/)
      scheme_missing = true
      address = 'http://' + address
    end

    scheme,
    userinfo,
    host,
    port,
    registry, # Not used by HTTP
    path,
    opaque,   # Not used by HTTP
    query,
    fragment = URI.split(address)

    scheme = nil if scheme_missing
    path   = nil if (path == '')

    unless scheme
      scheme = (port.to_i == URI::HTTPS::DEFAULT_PORT) ? 'https' : 'http'
    end

    build_uri :scheme   => scheme,
              :userinfo => userinfo,
              :host     => host,
              :port     => port,
              :path     => path,
              :query    => query,
              :fragment => fragment
  end

protected

  def self.clear_cookies_if_host_changes(request)
    previous_host = request.uri.host
    yield
    request.cookies_remove_all unless request.uri.host == previous_host
    request
  end

public

  # Returns the HTTP method of the request, if any.
  attr_reader :request_method

  # Returns the response received for the request, if any.
  attr_reader :response

  # Returns the URI of the request.
  attr_reader :uri

  # Initializes a new HTTY::Request with a #uri corresponding to the specified
  # _address_.
  def initialize(address)
    super({:headers => [['User-Agent', "htty/#{HTTY::VERSION}"]]})
    @uri = self.class.parse_uri(address)
    establish_content_length
  end

  def initialize_copy(source) #:nodoc:
    super
    @response = @response.dup if @response
    @uri      = @uri.dup
  end

  # Returns +true+ if _other_request_ is equivalent to the request.
  def ==(other_request)
    return false unless super(other_request)
    return false unless other_request.kind_of?(self.class)
    (other_request.response == response) && (other_request.uri == uri)
  end
  alias :eql? :==

  # Establishes a new #uri corresponding to the specified _address_. If the host
  # of the _address_ is different from the host of #uri, then #cookies are
  # cleared.
  def address(address)
    uri = self.class.parse_uri(address)
    if response
      dup = dup_without_response
      return self.class.clear_cookies_if_host_changes(dup) do
        dup.uri = uri
      end
    end

    self.class.clear_cookies_if_host_changes self do
      @uri = uri
    end
  end

  # Sets the body of the request.
  def body_set(body)
    return dup_without_response.body_set(body) if response

    @body = body ? body.to_s : nil
    establish_content_length
  end

  # Clears the body of the request.
  def body_unset
    body_set nil
  end

  # Makes an HTTP +CONNECT+ request using the path of #uri.
  def connect!
    request! :connect
  end

  # Appends to #cookies using the specified _name_ (required) and _value_
  # (optional).
  def cookie_add(name, value=nil)
    return dup_without_response.cookie_add(name, value) if response

    cookies_string = HTTY::CookiesUtil.cookies_to_string(cookies +
                                                         [[name.to_s, value]])
    if cookies_string
      @headers[COOKIES_HEADER_NAME] = cookies_string
    else
      @headers.delete COOKIES_HEADER_NAME
    end
    self
  end

  # Removes the last element of #cookies having the specified _name_.
  def cookie_remove(name)
    return dup_without_response.cookie_remove(name) if response

    # Remove just one matching cookie from the end.
    rejected = false
    new_cookies = cookies.reverse.reject do |cookie_name, cookie_value|
      if !rejected && (cookie_name == name)
        rejected = true
      else
        false
      end
    end.reverse

    cookies_string = HTTY::CookiesUtil.cookies_to_string(new_cookies)
    if cookies_string
      @headers[COOKIES_HEADER_NAME] = cookies_string
    else
      @headers.delete COOKIES_HEADER_NAME
    end
    self
  end

  # Returns an array of the cookies belonging to the request.
  def cookies
    HTTY::CookiesUtil.cookies_from_string @headers[COOKIES_HEADER_NAME]
  end

  # Removes all #cookies.
  def cookies_remove_all
    return dup_without_response.cookies_remove_all if response

    @headers.delete COOKIES_HEADER_NAME
    self
  end

  # Sets #cookies according to the _Set-Cookie_ header of the specified
  # _response_, or raises either HTTY::NoResponseError or
  # HTTY::NoSetCookieHeaderError.
  def cookies_use(response)
    raise HTTY::NoResponseError unless response

    cookies_header = response.headers.detect do |name, value|
      name == HTTY::Response::COOKIES_HEADER_NAME
    end
    unless cookies_header && cookies_header.last
      raise HTTY::NoSetCookieHeaderError
    end
    header_set COOKIES_HEADER_NAME, cookies_header.last
  end

  # Makes an HTTP +DELETE+ request using the path of #uri.
  def delete!
    request! :delete
  end

  # Establishes a new #uri according to the _Location_ header of the specified
  # _response_, or raises either HTTY::NoResponseError or
  # HTTY::NoLocationHeaderError.
  def follow(response)
    raise HTTY::NoResponseError unless response

    location_header = response.headers.detect do |name, value|
      name == 'Location'
    end
    unless location_header && location_header.last
      raise HTTY::NoLocationHeaderError
    end
    address location_header.last
  end

  # Establishes a new #uri with the specified _fragment_.
  def fragment_set(fragment)
    rebuild_uri :fragment => fragment
  end

  # Establishes a new #uri without a fragment.
  def fragment_unset
    fragment_set nil
  end

  # Makes an HTTP +GET+ request using the path of #uri.
  def get!
    request! :get
  end

  # Makes an HTTP +HEAD+ request using the path of #uri.
  def head!
    request! :head
  end

  # Appends to #headers or changes the element of #headers using the specified
  # _name_ and _value_.
  def header_set(name, value)
    return dup_without_response.header_set(name, value) if response

    name = name.to_s
    if value.nil?
      @headers.delete name
      return self
    end

    @headers[name] = value.to_s
    self
  end

  # Removes the element of #headers having the specified _name_.
  def header_unset(name)
    header_set name, nil
  end

  # Returns an array of the headers belonging to the payload. If
  # _include_content_length_ is +false+, then a 'Content Length' header will be
  # omitted. If _include_content_length_ is not specified, then it will be
  # +true+ if #request_method is an HTTP method for which body content is
  # expected.
  def headers(include_content_length=
              METHODS_SENDING_BODY.include?(request_method))
    unless include_content_length
      return super().reject do |name, value|
        name == 'Content-Length'
      end
    end

    super()
  end

  # Removes all #headers.
  def headers_unset_all
    return dup_without_response.headers_unset_all if response

    @headers.clear
    self
  end

  # Establishes a new #uri with the specified _host_.
  def host_set(host)
    rebuild_uri :host => host
  end

  # Makes an HTTP +OPTIONS+ request using the path of #uri.
  def options!
    request! :options
  end

  # Makes an HTTP +PATCH+ request using the path of #uri.
  def patch!
    request! :patch
  end

  # Establishes a new #uri with the specified _path_ which may be absolute or
  # relative.
  def path_set(path)
    absolute_path = (Pathname.new(uri.path) + path).to_s
    rebuild_uri :path => absolute_path
  end

  # Establishes a new #uri with the specified _port_.
  def port_set(port)
    rebuild_uri :port => port
  end

  # Makes an HTTP +POST+ request using the path of #uri.
  def post!
    request! :post
  end

  # Makes an HTTP +PUT+ request using the path of #uri.
  def put!
    request! :put
  end

  # Establishes a new #uri, with the specified _value_ for the query-string
  # parameter specified by _name_.
  def query_set(name, value)
    query     = uri.query ? "&#{uri.query}&" : ''
    parameter = Regexp.new("&#{Regexp.escape name}=.+?&")
    if query =~ parameter
      new_query = value.nil? ?
                  query.gsub(parameter, '&') :
                  query.gsub(parameter, "&#{name}=#{value}&")
    else
      new_query = value.nil? ? query : "#{query}#{name}=#{value}"
    end
    new_query = new_query.gsub(/^&/, '').gsub(/&$/, '')
    new_query = nil if (new_query == '')
    rebuild_uri :query => new_query
  end

  # Establishes a new #uri, without the query-string parameter specified by
  # _name_.
  def query_unset(name)
    query_set name, nil
  end

  # Establishes a new #uri without a query string.
  def query_unset_all
    rebuild_uri :query => nil
  end

  # Establishes a new #uri with the specified _scheme_.
  def scheme_set(scheme)
    rebuild_uri :scheme => scheme
  end

  # Makes an HTTP +TRACE+ request using the path of #uri.
  def trace!
    request! :trace
  end

  # Establishes a new #uri with the specified _userinfo_.
  def userinfo_set(userinfo)
    rebuild_uri :userinfo => userinfo
  end

  # Establishes a new #uri without userinfo.
  def userinfo_unset
    userinfo_set nil
  end

protected

  def dup_without_response
    request = self.dup
    request.response = nil
    request.instance_variable_set '@request_method', nil
    request
  end

  def establish_content_length
    header_set 'Content-Length', body.to_s.length
  end

  def path_query_and_fragment
    self.class.build_path_query_and_fragment :path     => uri.path,
                                             :query    => uri.query,
                                             :fragment => uri.fragment
  end

  def rebuild_uri(changed_components)
    return dup_without_response.rebuild_uri(changed_components) if response

    components = URI::HTTP::COMPONENT.inject({}) do |result, c|
      result.merge c => uri.send(c)
    end
    self.class.clear_cookies_if_host_changes self do
      @uri = self.class.build_uri(components.merge(changed_components))
    end
  end

  attr_writer :response

  attr_writer :uri

private

  def authority
    self.class.build_authority :userinfo => uri.userinfo,
                               :host     => uri.host,
                               :port     => uri.port
  end

  def request!(method)
    request = response ? dup_without_response : self
    request.instance_variable_set '@request_method', method
    HTTY::RequestsUtil.send method, request
  end

end
