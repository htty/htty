require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/response")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/version")

require File.expand_path("#{File.dirname __FILE__}/shared_examples_for_requests")


shared_examples_for 'a request with basic authentication' do
  it 'should have userinfo in the URI' do
    expected_uri = URI.parse(uri)
    expected_uri.userinfo = [username, password].compact.join(':')
    subject.uri.should == expected_uri
  end

  it 'should have the Authorization header' do
    subject.headers.should == [
      user_agent_header,
      HTTY::Headers.basic_authentication_for(
        username, password
      )
    ]
  end
end

shared_examples_for 'a request without basic authentication' do
  it 'should not have userinfo in the URI' do
    expected_uri = URI.parse(uri)
    expected_uri.userinfo = nil
    subject.uri.should == expected_uri
  end

  it 'should not have the Authorization header' do
    subject.headers.should == [user_agent_header]
  end
end


describe HTTY::Request do
  let(:request) {HTTY::Request.new uri}
  let(:user_agent_header) {['User-Agent', 'htty/' + HTTY::VERSION]}

  subject {request}

  describe 'without basic authentication' do
    let(:uri) do
      "https://github.com:80/search/deep?q=http#content"
    end

    it_should_behave_like 'an empty request'
    it_should_behave_like 'a request without basic authentication'

    describe '#userinfo_unset' do
      before :each do
        subject.userinfo_unset
      end

      it_should_behave_like 'a request without basic authentication'
    end

    describe '#userinfo_set' do
      let(:username) {'njonsson'}
      let(:password) {'123'}

      before :each do
        subject.userinfo_set username, password
      end

      it_should_behave_like 'a request with basic authentication'

      context 'with empty password' do
        let(:password) {nil}

        it_should_behave_like 'a request with basic authentication'
      end
    end

    describe '#headers_set Authorization' do
      let(:username) {'njonsson'}
      let(:password) {'123'}

      before :each do
        subject.header_set 'Authorization',
          HTTY::Headers.basic_authentication_for(username, password).last
      end

      it_should_behave_like 'a request with basic authentication'
    end
  end

  describe 'with basic authentication' do
    let(:username) {'njonsson'}
    let(:password) {'123'}
    let(:uri) do
      "https://#{username}:#{password}@github.com:80/search/deep?q=http#content"
    end

    let(:basic_authentication) do
      HTTY::Headers.basic_authentication_for(username, password)
    end

    it_should_behave_like 'an empty, authenticated request'
    it_should_behave_like 'a request with basic authentication'

    describe '#userinfo_unset' do
      before :each do
        subject.userinfo_unset
      end

      it 'should have the same URI, without userinfo' do
        expected_uri = URI.parse(uri)
        expected_uri.user = nil
        subject.uri.should == expected_uri
      end
    end

    describe '#userinfo_set' do
      context 'with the same credentials' do
        before :each do
          subject.userinfo_set username, password
        end

        it 'should have the same URI' do
          subject.uri.should == URI.parse(uri)
        end

        it 'should have the same Authorization header' do
          subject.headers.should == [user_agent_header, basic_authentication]
        end
      end

      context 'with different credentials' do
        let(:different_username) {'gabrielelana'}
        let(:different_password) {'456'}

        before :each do
          subject.userinfo_set different_username, different_password
        end

        it 'should have the same URI, with the changed userinfo part' do
          expected_uri = URI.parse(uri)
          expected_uri.userinfo = [different_username, different_password].join(':')
          subject.uri.should == expected_uri
        end

        it 'should have changed the Authorization header' do
          subject.headers.should == [
            user_agent_header,
            HTTY::Headers.basic_authentication_for(
              different_username, different_password
            )
          ]
        end
      end

      context 'with credentials that contains an escaped character' do
        let(:username) {'n%40'}

        it 'should be escaped in the URI' do
          subject.uri.userinfo.should start_with(username)
        end

        it 'should not be escaped in the Authorization header' do
          subject.headers.should == [
            user_agent_header,
            HTTY::Headers.basic_authentication_for(
              URI.unescape(username), password
            )
          ]
        end
      end

      context 'with a response' do
        before :each do
          subject.send :response=, HTTY::Response.new
        end

        it 'should return a request without a response' do
          subject.userinfo_set(username, password).response.should be_nil
        end
      end
    end

    describe '#headers_unset Authorization' do
      before :each do
        subject.header_unset 'Authorization'
      end

      it 'should have the same URI, without userinfo' do
        expected_uri = URI.parse(uri)
        expected_uri.user = nil
        subject.uri.should == expected_uri
      end
    end

    describe '#headers_unset_all' do
      before :each do
        subject.headers_unset_all
      end

      it 'should have the same URI, without userinfo' do
        expected_uri = URI.parse(uri)
        expected_uri.user = nil
        subject.uri.should == expected_uri
      end
    end
  end
end
