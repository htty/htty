require 'net/http'
require 'net/https'
require 'uri'
require File.expand_path("#{File.dirname __FILE__}/http_patch")
require File.expand_path("#{File.dirname __FILE__}/preferences")
require File.expand_path("#{File.dirname __FILE__}/response")

module HTTY; end

# Provides support for making HTTP(S) requests.
module HTTY::RequestsUtil

  # Makes an HTTP DELETE request with the specified _request_.
  def self.delete(request)
    request(request) do |host|
      host.delete request.send(:path_query_and_fragment), headers_from(request)
    end
  end

  # Makes an HTTP GET request with the specified _request_.
  def self.get(request)
    request(request) do |host|
      host.request_get request.send(:path_query_and_fragment), headers_from(request)
    end
  end

  # Makes an HTTP HEAD request with the specified _request_.
  def self.head(request)
    request(request) do |host|
      host.head request.send(:path_query_and_fragment), headers_from(request)
    end
  end

  # Makes an HTTP OPTIONS request with the specified _request_.
  def self.options(request)
    request(request) do |host|
      host.options request.send(:path_query_and_fragment), headers_from(request)
    end
  end

  # Makes an HTTP PATCH request with the specified _request_.
  def self.patch(request)
    request(request) do |host|
      host.patch request.send(:path_query_and_fragment),
                 request.body,
                 headers_from(request)
    end
  end

  # Makes an HTTP POST request with the specified _request_.
  def self.post(request)
    request(request) do |host|
      host.post request.send(:path_query_and_fragment),
                request.body,
                headers_from(request)
    end
  end

  # Makes an HTTP PUT request with the specified _request_.
  def self.put(request)
    request(request) do |host|
      host.put request.send(:path_query_and_fragment),
               request.body,
               headers_from(request)
    end
  end

  # Makes an HTTP TRACE request with the specified _request_.
  def self.trace(request)
    request(request) do |host|
      host.trace request.send(:path_query_and_fragment), headers_from(request)
    end
  end

protected

  def self.http_response_to_status(http_response)
    [http_response.code,
     http_response.code_type.name.gsub(/^Net::HTTP/,       '').
                                  gsub(/(\S)([A-Z][a-z])/, '\1 \2')]
  end

private

  def self.request(request)
    http = Net::HTTP.new(request.uri.host, request.uri.port)

    if request.uri.kind_of?(URI::HTTPS)
      http.use_ssl = true
      http.verify_mode = HTTY::Preferences.current.verify_certificates? ?
                         OpenSSL::SSL::VERIFY_PEER                      :
                         OpenSSL::SSL::VERIFY_NONE
    end

    http.start do |host|
      http_response = yield(host)
      headers = []
      http_response.canonical_each do |*h|
        headers << h
      end
      request.send :response=,
                   HTTY::Response.new(:status  => http_response_to_status(http_response),
                                      :headers => headers,
                                      :body    => http_response.body)
    end
    request
  end

  def self.headers_from(request)
    return request.headers unless HEADERS_MUST_BE_AN_HASH
    return {} if request.headers.empty?
    request.headers.flatten.each_slice(2).reduce({}) do |hash, pair|
      hash[pair.first] = pair.last
      hash
    end
  end

  # starting from 2.0.0 net/http requires headers to be hashes
  HEADERS_MUST_BE_AN_HASH =
    Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.0.0')

end
