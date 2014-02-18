require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/response")


describe HTTY::Request do
  let(:request_address) {'http://example.com/a?b=c#d'}
  let(:request) {HTTY::Request.new request_address}

  describe '#follow a response' do
    let(:response) do
      HTTY::Response.new({:headers => {'Location' => response_location}})
    end

    before :each do
      request.send :response=, response
    end

    describe 'with an absolute URI in Location header' do
      let(:response_location) {'http://followme.com/a/b/c'}

      it 'should return another request' do
        request.follow(response).should_not == request
      end

      it 'should return a request with the absolute URI as its HTTP URI' do
        request.follow(response).uri.should == URI.parse(response_location)
      end
    end

    describe 'with an absolute path in Location header' do
      let(:response_location) {'/a/b/c'}

      it 'should return a request with the same URI host ' +
         'and with the URI path changed to the absolute path in Location' do
        expected_uri = URI.parse(request_address)
        expected_uri.path = response_location
        expected_uri.query = nil
        expected_uri.fragment = nil
        request.follow(response).uri.should == expected_uri
      end
    end

    describe 'with a relative path in Location header' do
      let(:response_location) {'a/b/c'}

      it 'should return a request with the same URI host ' +
         'and with the URI path changed joining the ' +
         'original URI path to the relative path in Location' do
        expected_uri = URI.parse(request_address)
        expected_uri.path = File.join(expected_uri.path, response_location)
        expected_uri.query = nil
        expected_uri.fragment = nil
        request.follow(response).uri.should == expected_uri
      end

      context 'when invoked more than once' do
        let(:after_follow) {request.follow(response)}

        it 'should return always the same request' do
          after_follow.uri.should == after_follow.follow(response).uri
        end
      end
    end

    describe 'with an URI with query string in Location header' do
      let(:response_location) {'a/b/c?d=e&f=g'}

      it 'should return a request with URI query string ' +
         'equal to the Location query string' do
        expected_query = URI.parse(response_location).query
        request.follow(response).uri.query.should == expected_query
      end

      it 'should return a request without URI fragment' do
        request.follow(response).uri.fragment.should be_nil
      end
    end

    describe 'with an URI with fragment in Location header' do
      let(:response_location) {'a/b/c#f'}

      it 'should return a request with URI fragment ' +
         'equal to the Location fragment' do
        expected_fragment = URI.parse(response_location).fragment
        request.follow(response).uri.fragment.should == expected_fragment
      end

      it 'should return a request without URI query string' do
        request.follow(response).uri.query.should be_nil
      end
    end
  end
end
