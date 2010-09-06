# Defines HTTY::RequestsUtil.

require 'net/http'
require 'uri'
require File.expand_path("#{File.dirname __FILE__}/response")

module HTTY; end

# Provides support for making HTTP(S) requests.
module HTTY::RequestsUtil

  # Makes an HTTP DELETE request with the specified _request_.
  def self.delete(request)
    request(request) do |host|
      host.delete request.send(:path_query_and_fragment), request.headers
    end
  end

  # Makes an HTTP GET request with the specified _request_.
  def self.get(request)
    request(request) do |host|
      host.request_get request.send(:path_query_and_fragment), request.headers
    end
  end

  # Makes an HTTP HEAD request with the specified _request_.
  def self.head(request)
    request(request) do |host|
      host.head request.send(:path_query_and_fragment), request.headers
    end
  end

  # Makes an HTTP OPTIONS request with the specified _request_.
  def self.options(request)
    request(request) do |host|
      host.options request.send(:path_query_and_fragment), request.headers
    end
  end

  # Makes an HTTP POST request with the specified _request_.
  def self.post(request)
    request(request) do |host|
      host.post request.send(:path_query_and_fragment),
                request.body,
                request.headers
    end
  end

  # Makes an HTTP PUT request with the specified _request_.
  def self.put(request)
    request(request) do |host|
      host.put request.send(:path_query_and_fragment),
               request.body,
               request.headers
    end
  end

  # Makes an HTTP TRACE request with the specified _request_.
  def self.trace(request)
    request(request) do |host|
      host.trace request.send(:path_query_and_fragment), request.headers
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
    http.use_ssl = true if (request.uri === URI::HTTPS)
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

end
