require 'base64'
require 'pathname'
require 'uri'
require File.expand_path("#{File.dirname __FILE__}/../htty/version")
require File.expand_path("#{File.dirname __FILE__}/cookies_util")
require File.expand_path("#{File.dirname __FILE__}/no_location_header_error")
require File.expand_path("#{File.dirname __FILE__}/no_response_error")
require File.expand_path("#{File.dirname __FILE__}/no_set_cookie_header_error")
require File.expand_path("#{File.dirname __FILE__}/uri")
require File.expand_path("#{File.dirname __FILE__}/payload")
require File.expand_path("#{File.dirname __FILE__}/requests_util")
require File.expand_path("#{File.dirname __FILE__}/response")

module HTTY; end

# Encapsulates an HTTP(S) request.
class HTTY::Request < HTTY::Payload

  AUTHORIZATION_HEADER_NAME = 'Authorization'
  COOKIES_HEADER_NAME       = 'Cookie'

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
    unless %w(http:// https://).include?(scheme)
      raise ArgumentError, 'only http:// and https:// schemes are supported'
    end

    authority               = build_authority(components)
    path_query_and_fragment = build_path_query_and_fragment(components)
    path_query_and_fragment ||= '/' if authority
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

  def self.set_up_cookies_and_authentication(request)
    previous_host = request.uri.host
    yield
    request.cookies_remove_all unless request.uri.host == previous_host

    request.send :establish_basic_authentication

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
    establish_basic_authentication
    establish_content_length
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
      return self.class.send(:set_up_cookies_and_authentication, dup) do
        dup.uri = uri
      end
    end

    self.class.send(:set_up_cookies_and_authentication, self) do
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

  # Returns true if has some cookies.
  def cookies?
    not cookies.empty?
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
    response.follow_relative_to(self)
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

    name = name && name.to_s
    value = value && value.to_s

    # to avoid recursion when rebuild_uri
    return self if @headers[name] == value

    if value.nil?
      @headers.delete name
      if name.downcase == AUTHORIZATION_HEADER_NAME.downcase
        return rebuild_uri :userinfo => nil
      end
      return self
    end

    @headers[name] = value
    if name.downcase == AUTHORIZATION_HEADER_NAME.downcase
      HTTY::Headers.credentials_from(value) do |username, password|
        return rebuild_uri :userinfo => [
          HTTY::URI.escape_component(username),
          HTTY::URI.escape_component(password)
        ].compact.join(':')
      end
    end
    self
  end

  # Removes the element of #headers having the specified _name_.
  def header_unset(name)
    header_set name, nil
  end

  # Removes all #headers.
  def headers_unset_all
    return dup_without_response.headers_unset_all if response

    @headers.clear
    rebuild_uri :userinfo => nil
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

  # Establishes a new #uri with an additional query-string parameter specified
  # by _name_ and _value_. The _value_ is optional.
  def query_add(name, value=nil)
    entries = current_query_entries
    entries << name + (value.nil? ? '' : "=#{value}")
    query_set_all(entries)
  end

  # Establishes a new #uri with the specified _value_ for the query-string
  # parameter specified by _name_. The _value_ is optional.
  #
  # If there is more than one query-string parameter named _name_, they are
  # replaced by a single one with the specified _value_.
  def query_set(name, value=nil)
    entries = current_query_entries
    add_or_replace_field(entries, name, value)
    query_set_all(entries)
  end

  # Establishes a new #uri with the query-string parameter specified by by
  # _query_string_ parameter
  def query_set_all(query_string)
    # _query_string_ as an array of parameters is only for internal usage
    query_string =
      case query_string
        when Array
          query_string.empty? ? nil : query_string.join('&')
        when String
          query_string
        else
          nil
      end
    rebuild_uri :query => query_string
  end

  # Establishes a new #uri, removing the last query-string parameter specified
  # by _name_ and _value_. The _value_ is optional.
  #
  # If there is more than one query-string parameter named _name_, those
  # parameters matching both _name_ and _value_ (if specified) are removed.
  def query_remove(name, value=nil)
    return unless uri.query
    entries = current_query_entries
    entries.reverse.each do |entry|
      if entry =~ field_matcher(name, value)
        entries.delete(entry)
        break
      end
    end
    query_set_all(entries)
  end

  # Establishes a new #uri without the query-string parameter specified by
  # _name_.
  #
  # If there is more than one query-string parameter named _name_, they are
  # removed.
  def query_unset(name)
    return unless uri.query
    entries = current_query_entries
    entries.delete_if do |entry|
      entry =~ field_matcher(name)
    end
    query_set_all(entries)
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
  def userinfo_set(username, password=nil)
    userinfo = [username, password].compact.join(':')
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

  def establish_basic_authentication
    value = uri.userinfo                                                 ?
            "Basic #{Base64.encode64(URI.unescape(uri.userinfo)).chomp}" :
            nil
    header_set AUTHORIZATION_HEADER_NAME, value
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
    components = components.merge(changed_components)
    components[:query] = nil if components[:query] && components[:query].empty?
    self.class.send(:set_up_cookies_and_authentication, self) do
      @uri = self.class.build_uri(components)
    end
  end

  attr_writer :response

  attr_writer :uri

private

  def add_or_replace_field(chunks, name, value)
    new_entry = name + (value.nil? ? '' : "=#{value}")
    has_matched = false
    chunks.each do |chunk|
      if chunk =~ field_matcher(name)
        if has_matched
          chunks.delete chunk
        else
          chunks[chunks.index(chunk)] = new_entry
          has_matched = true
        end
      end
    end
    chunks << new_entry unless has_matched
  end

  def authority
    self.class.build_authority :userinfo => uri.userinfo,
                               :host     => uri.host,
                               :port     => uri.port
  end

  def current_query_entries
    uri.query ? uri.query.split('&') : []
  end

  def establish_content_length
    header_set 'Content-Length', body.to_s.length
  end

  def field_matcher(name, value=nil)
    escaped = Regexp.escape(name)
    if value
      Regexp.new "^(#{escaped}\=#{Regexp.escape(value)})$"
    else
      Regexp.new "^(#{escaped}|#{escaped}\=.*)$"
    end
  end

  def request!(method)
    request = response ? dup_without_response : self
    request.instance_variable_set '@request_method', method
    HTTY::RequestsUtil.send method, request
  end

end
