require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/response")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/version")

require File.expand_path("#{File.dirname __FILE__}/shared_examples_for_requests")

describe HTTY::Request do
  let(:username) {'njonsson'}
  let(:password) {nil}

  describe 'initializing with' do
    let :klass do
      HTTY::Request
    end

    describe 'a valid FTP address' do
      it 'should raise URI::InvalidURIError' do
        expect do
          klass.new 'ftp://myftpsite.info'
        end.to raise_error(ArgumentError,
                           'only http:// and https:// schemes are supported')
      end
    end
  end

  describe 'with a nil address' do
    let :request do
      HTTY::Request.new nil
    end

    it 'should have the URI http://0.0.0.0:80/' do
      request.uri.should == URI.parse('http://0.0.0.0:80/')
    end

    it_should_behave_like 'an empty request'
  end

  describe 'with an empty address' do
    let :request do
      HTTY::Request.new ''
    end

    it 'should have the URI http://0.0.0.0:80/' do
      request.uri.should == URI.parse('http://0.0.0.0:80/')
    end

    it_should_behave_like 'an empty request'
  end

  describe 'with an address consisting of' do
    describe 'an IPv4 address' do
      let :request do
        HTTY::Request.new '127.0.0.1'
      end

      it 'should have an HTTP URI for that host' do
        request.uri.should == URI.parse('http://127.0.0.1:80/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname' do
      let :request do
        HTTY::Request.new 'localhost'
      end

      it 'should have HTTP URI for that host' do
        request.uri.should == URI.parse('http://localhost:80/')
      end

      it_should_behave_like 'an empty request'

      describe '-- when sent #query_set' do
        describe 'with a query parameter --' do
          before :each do
            request.query_set 'foo', 'bar'
          end

          it 'should have a URI including the query parameter' do
            request.uri.should == URI.parse('http://localhost:80/?foo=bar')
          end

          it_should_behave_like 'an empty request'
        end
      end
    end

    describe 'a hostname and a port' do
      let :request do
        HTTY::Request.new 'localhost:8080'
      end

      it 'should have an HTTP URI for that host on that port' do
        request.uri.should == URI.parse('http://localhost:8080/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'the HTTP scheme and a hostname' do
      let :request do
        HTTY::Request.new 'http://localhost'
      end

      it 'should have an HTTP URI for that host' do
        request.uri.should == URI.parse('http://localhost:80/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'the HTTPS scheme, userinfo, and a hostname' do
      let :request do
        HTTY::Request.new 'https://njonsson@github.com'
      end

      it 'should have an HTTPS URI for host with that userinfo' do
        request.uri.should == URI.parse('https://njonsson@github.com:443/')
      end

      it_should_behave_like 'an empty, authenticated request'
    end

    describe 'a hostname and the root path' do
      let :request do
        HTTY::Request.new 'github.com/'
      end

      it 'should have an HTTP URI for the root of that host' do
        request.uri.should == URI.parse('http://github.com:80/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname, port 443, and the root path' do
      let :request do
        HTTY::Request.new 'github.com:443/'
      end

      it 'should have an HTTPS URI for the root of that host' do
        request.uri.should == URI.parse('https://github.com:443/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'the HTTP scheme, a hostname, port 443, and the root path' do
      let :request do
        HTTY::Request.new 'http://github.com:443/'
      end

      it 'should have an HTTP URI for the root of that host on port 443' do
        request.uri.should == URI.parse('http://github.com:443/')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname and a path' do
      let :request do
        HTTY::Request.new 'github.com/explore'
      end

      it 'should have an HTTP URI for that path on that host' do
        request.uri.should == URI.parse('http://github.com:80/explore')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname and a query string' do
      let :request do
        HTTY::Request.new 'github.com?search=http'
      end

      it 'should have an HTTP URI for that query string and the root of ' +
         'that host' do
        request.uri.should == URI.parse('http://github.com:80/?search=http')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname, a path, and a query string' do
      let :request do
        HTTY::Request.new 'github.com/search?q=http&lang=en'
      end

      it 'should have an HTTP URI for that query string and that path on ' +
         'that host' do
        request.uri.should == URI.parse('http://github.com:80' +
                                        '/search?q=http&lang=en')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname, a path, and a fragment' do
      let :request do
        HTTY::Request.new 'github.com/explore#trending'
      end

      it 'should have an HTTP URI for that fragment of that path on that ' +
         'host' do
        request.uri.should == URI.parse('http://github.com:80/explore#trending')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'a hostname, a port, a path, a query string, and a fragment' do
      let :request do
        HTTY::Request.new 'github.com:123/search/deep?q=http&lang=en#content'
      end

      it 'should have an HTTP URI for that query string and that fragment ' +
         'of that path on that host on that port' do
        request.uri.should == URI.parse('http://github.com:123'       +
                                        '/search/deep?q=http&lang=en' +
                                        '#content')
      end

      it_should_behave_like 'an empty request'
    end

    describe 'the HTTPS scheme, userinfo, a hostname, a port, a path, a ' +
             'query string, and a fragment' do
      let :request do
        HTTY::Request.new 'https://njonsson@github.com:123' +
                          '/search/deep?q=http&lang=en#content'
      end

      describe 'and without a response' do
        it 'should not have a response' do
          request.response.should be_nil
        end

        describe '-- and is untouched --' do
          it 'should have an HTTPS URI for that query string and that '   +
             'fragment of that path on that host on that port with that ' +
             'userinfo' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep?q=http&lang=en'     +
                                            '#content')
          end

          it_should_behave_like 'an empty, authenticated request'
        end

        describe '-- when sent #address with an address consisting of' do
          describe 'the HTTP scheme and different userinfo, hostname, port, ' +
                   'path, query string, and fragment --' do
            before :each do
              request.address 'http://steve@mac.com:456/archives/2010' +
                              '?author=jobs&subject=html5#flames'
            end

            it 'should have an HTTP URI for the new query string and the new ' +
               'fragment of the new path on the new host on the new port '     +
               'with the new userinfo' do
              request.uri.should == URI.parse('http://steve@mac.com:456'   +
                                              '/archives/2010'             +
                                              '?author=jobs&subject=html5' +
                                              '#flames')
            end

            it 'should the expected Authorization header plus the default ' +
               'headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic c3RldmU=']]
            end

            it 'should have no body' do
              request.body.should be_nil
            end

            it 'should have no response' do
              request.response.should be_nil
            end
          end

          describe 'a different hostname --' do
            before :each do
              request.address 'mac.com'
            end

            it 'should have an HTTP URI for the new host' do
              request.uri.should == URI.parse('http://mac.com:80/')
            end

            it_should_behave_like 'an empty request'
          end
        end

        describe '-- when sent #scheme_set with' do
          describe 'the same scheme --' do
            before :each do
              request.scheme_set 'https'
            end

            it 'should have an unchanged URI' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'a different scheme --' do
            before :each do
              request.scheme_set 'http'
            end

            it 'should have the same URI, with the changed scheme' do
              request.uri.should == URI.parse('http://njonsson@github.com'  +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #host_set with' do
          describe 'the same host --' do
            before :each do
              request.host_set 'github.com'
            end

            it 'should have an unchanged URI' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'a different host --' do
            before :each do
              request.host_set 'gist.github.com'
            end

            it 'should have the same URI, with the changed scheme' do
              request.uri.should == URI.parse('https://'                     +
                                              'njonsson@gist.github.com:123' +
                                              '/search/deep?q=http&lang=en'  +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #port_set with' do
          describe 'the same port --' do
            before :each do
              request.port_set 123
            end

            it 'should have an unchanged URI' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'a different port --' do
            before :each do
              request.port_set 8888
            end

            it 'should have the same URI, with the changed scheme' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':8888'                       +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #path_set with a path consisting of' do
          describe 'a child reference --' do
            before :each do
              request.path_set 'foo'
            end

            it 'should have the same URI, descending to the expected path' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep/foo'            +
                                              '?q=http&lang=en#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'a parent reference --' do
            before :each do
              request.path_set '..'
            end

            it 'should have the same URI, ascending to the expected path' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search?q=http&lang=en#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'an absolute reference --' do
            before :each do
              request.path_set '/foo/bar'
            end

            it 'should have the same URI, changing to the expected path' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/foo/bar?q=http&lang=en'     +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #query_set' do
          describe 'with a new query parameter --' do
            before :each do
              request.query_set 'foo', 'bar'
            end

            it 'should have a URI including the new query parameter' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                               ':123'                        +
                                               '/search/deep'                +
                                               '?q=http&lang=en&foo=bar'     +
                                               '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'with a new value for the first query parameter --' do
            before :each do
              request.query_set 'q', 'ruby'
            end

            it 'should have a URI with the new value of the query parameter' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=ruby&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'with a new value for the second query parameter --' do
            before :each do
              request.query_set 'lang', 'fr'
            end

            it 'should have a URI with the new value of the second query ' +
               'parameter' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=fr' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #query_unset' do
          describe 'with a nonexistent query parameter --' do
            before :each do
              request.query_unset 'fizzle'
            end

            it 'should have an unchanged URI' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'with the first query parameter --' do
            before :each do
              request.query_unset 'q'
            end

            it 'should have a URI missing the first query parameter' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?lang=en#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'with the second query parameter --' do
            before :each do
              request.query_unset 'lang'
            end

            it 'should have a URI missing the second query parameter' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #query_unset_all --' do
          before :each do
            request.query_unset_all
          end

          it 'should have a URI having no query string' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep#content')
          end

          it_should_behave_like 'an empty, authenticated request'
        end

        describe '-- when sent #fragment_set with' do
          describe 'the same fragment --' do
            before :each do
              request.fragment_set 'content'
            end

            it 'should have an unchanged URI' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#content')
            end

            it_should_behave_like 'an empty, authenticated request'
          end

          describe 'different fragment --' do
            before :each do
              request.fragment_set 'details'
            end

            it 'should have the same URI, with the changed fragment' do
              request.uri.should == URI.parse('https://njonsson@github.com' +
                                              ':123'                        +
                                              '/search/deep?q=http&lang=en' +
                                              '#details')
            end

            it_should_behave_like 'an empty, authenticated request'
          end
        end

        describe '-- when sent #fragment_unset --' do
          before :each do
            request.fragment_unset
          end

          it 'should have the same URI, without fragment' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep?q=http&lang=en')
          end

          it_should_behave_like 'an empty, authenticated request'
        end

        describe '-- when sent #header_set with a new header' do
          before :each do
            request.header_set 'foo', 'bar'
          end

          it 'should have an unchanged URI' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep?q=http&lang=en'     +
                                            '#content')
          end

          describe '--' do
            it 'should have the header, plus the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24='],
                                         ['foo',           'bar']]
            end
          end

          describe 'and then #header_unset' do
            describe 'with the same header name --' do
              before :each do
                request.header_unset 'foo'
              end

              it 'should have only the default headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24=']]
              end
            end

            describe 'with a different header name --' do
              before :each do
                request.header_unset 'qux'
              end

              it 'should have the header, plus the default headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24='],
                                           ['foo',           'bar']]
              end
            end
          end

          describe 'and then #headers_unset_all --' do
            before :each do
              request.headers_unset_all
            end

            it 'should have no headers' do
              request.headers.should be_empty
            end
          end
        end

        describe '-- when sent #cookie_add with a cookie' do
          before :each do
            request.cookie_add 'foo', 'bar'
          end

          it 'should have an unchanged URI' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep?q=http&lang=en'     +
                                            '#content')
          end

          describe '--' do
            it 'should have the cookie' do
              request.cookies.should == [%w(foo bar)]
            end

            it 'should have the cookie header, plus the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24='],
                                         ['Cookie',        'foo=bar']]
            end
          end

          describe 'and then #cookie_add' do
            describe 'with the same cookie name --' do
              before :each do
                request.cookie_add 'foo', 'qux'
              end

              it 'should have the new cookie, plus the old cookie' do
                request.cookies.should == [%w(foo bar), %w(foo qux)]
              end

              it 'should have the new cookie header, plus the default ' +
                 'headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24='],
                                           ['Cookie',        'foo=bar; ' +
                                                             'foo=qux']]
              end
            end

            describe 'with a different cookie name --' do
              before :each do
                request.cookie_add 'baz', 'qux'
              end

              it 'should have the new cookie' do
                request.cookies.should == [%w(foo bar), %w(baz qux)]
              end

              it 'should have the new cookie header, plus the default ' +
                 'headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24='],
                                           ['Cookie',        'foo=bar; ' +
                                                             'baz=qux']]
              end
            end

            describe 'with a different cookie name and no value --' do
              before :each do
                request.cookie_add 'baz'
              end

              it 'should have the new cookie' do
                request.cookies.should == [['foo', 'bar'], ['baz', nil]]
              end

              it 'should have the new cookie header, plus the default ' +
                 'headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24='],
                                           ['Cookie',        'foo=bar; baz']]
              end
            end
          end

          describe 'and then #cookie_remove' do
            describe 'with the same cookie name --' do
              before :each do
                request.cookie_remove 'foo'
              end

              it 'should have no cookie' do
                request.cookies.should be_empty
              end

              it 'should have only the default headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24=']]
              end
            end

            describe 'with a different cookie name --' do
              before :each do
                request.cookie_remove 'qux'
              end

              it 'should have the cookie' do
                request.cookies.should == [%w(foo bar)]
              end

              it 'should have the cookie header, plus the default headers' do
                request.headers.should == [['User-Agent',    'htty/' +
                                                             HTTY::VERSION],
                                           ['Authorization', 'Basic ' +
                                                             'bmpvbnNzb24='],
                                           ['Cookie',        'foo=bar']]
              end
            end
          end

          describe 'and then #cookies_remove_all --' do
            before :each do
              request.cookies_remove_all
            end

            it 'should have no cookies' do
              request.cookies.should be_empty
            end

            it 'should have only the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24=']]
            end
          end

          describe 'and then #address' do
            describe 'with the same host --' do
              before :each do
                request.address 'http://github.com'
              end

              it 'should have the cookie' do
                request.cookies.should == [%w(foo bar)]
              end

              it 'should have the cookie header, plus the default headers' do
                request.headers.should == [['User-Agent', 'htty/' +
                                                          HTTY::VERSION],
                                           ['Cookie',     'foo=bar']]
              end
            end

            describe 'with a different host --' do
              before :each do
                request.address 'http://google.com'
              end

              it 'should have no cookies' do
                request.cookies.should == []
                request.cookies.should be_empty
              end

              it 'should have only the default headers' do
                request.headers.should == [['User-Agent',
                                            "htty/#{HTTY::VERSION}"]]
              end
            end
          end
        end

        describe "-- when sent #cookie_add with a new cookie containing '='" do
          before :each do
            request.cookie_add 'foo', 'bar=baz=qux'
          end

          describe '--' do
            it 'should have the cookie' do
              request.cookies.should == [%w(foo bar=baz=qux)]
            end

            it 'should have the cookie header, plus the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24='],
                                         ['Cookie',        'foo=bar=baz=qux']]
            end
          end
        end

        describe '-- when sent #body_set with a body' do
          before :each do
            request.body_set 'foo'
          end

          it 'should have an unchanged URI' do
            request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                            '/search/deep?q=http&lang=en'     +
                                            '#content')
          end

          describe '--' do
            it 'should have the body' do
              request.body.should == 'foo'
            end

            it 'should have only the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24=']]
            end

            it "should have the expected 'Content-Length' header, plus the " +
               "'User-Agent' header if we do not exclude the "               +
               "'Content-Length' header" do
              request.headers(true).should == [['User-Agent',     'htty/' +
                                                                  HTTY::VERSION],
                                               ['Authorization',  'Basic '   +
                                                                  'bmpvbnNz' +
                                                                  'b24='],
                                               ['Content-Length', '3']]
            end
          end

          describe 'and then #body_unset' do
            before :each do
              request.body_unset
            end

            it 'should have no body' do
              request.body.should be_nil
            end

            it 'should have only the default headers' do
              request.headers.should == [['User-Agent',    'htty/' +
                                                           HTTY::VERSION],
                                         ['Authorization', 'Basic ' +
                                                           'bmpvbnNzb24=']]
            end
          end
        end
      end

      describe 'and with a response' do
        let :response do
          HTTY::Response.new
        end

        before :each do
          request.send :response=, response
        end

        it 'should not affect the URI' do
          request.uri.should == URI.parse('https://njonsson@github.com:123' +
                                          '/search/deep?q=http&lang=en'     +
                                          '#content')
        end

        it 'should not affect the headers' do
          request.headers.should == [['User-Agent',    'htty/' +
                                                       HTTY::VERSION],
                                     ['Authorization', 'Basic ' +
                                                       'bmpvbnNzb24=']]
        end

        it 'should not affect the body' do
          request.body.should be_nil
        end

        it 'should not affect the response' do
          request.response.should == response
        end

        describe '-- when sent #address with a different hostname --' do
          let :new_request do
            request.address 'mac.com'
          end

          it 'should return a request with an HTTP URI for the new host' do
            new_request.uri.should == URI.parse('http://mac.com:80/')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #scheme_set with a different scheme --' do
          let :new_request do
            request.scheme_set 'http'
          end

          it 'should return a request with the same URI having the changed ' +
             'scheme' do
            new_request.uri.should == URI.parse('http://njonsson@github.com'  +
                                                ':123'                        +
                                                '/search/deep?q=http&lang=en' +
                                                '#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #host_set with a different host --' do
          let :new_request do
            request.host_set 'gist.github.com'
          end

          it 'should return a request with the same URI having the changed ' +
             'host' do
            new_request.uri.should == URI.parse('https://'                    +
                                                'njonsson@gist.github.com'    +
                                                ':123'                        +
                                                '/search/deep?q=http&lang=en' +
                                                '#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #port_set with a different port --' do
          let :new_request do
            request.port_set 8888
          end

          it 'should return a request with the same URI having the changed ' +
             'port' do
            new_request.uri.should == URI.parse('https://njonsson@github.com' +
                                                ':8888'                       +
                                                '/search/deep?q=http&lang=en' +
                                                '#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #path_set with a different path --' do
          let :new_request do
            request.path_set 'foo'
          end

          it 'should return a request with the same URI having the changed ' +
             'path' do
            new_request.uri.should == URI.parse('https://njonsson@github.com' +
                                                ':123'                        +
                                                '/search/deep/foo'            +
                                                '?q=http&lang=en#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #query_set with a query parameter --' do
          let :new_request do
            request.query_set 'foo', 'bar'
          end

          it 'should return a request with the same URI having the new query ' +
             'parameter' do
            new_request.uri.should == URI.parse('https://njonsson@github.com' +
                                                ':123'                        +
                                                '/search/deep'                +
                                                '?q=http&lang=en&foo=bar'     +
                                                '#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #query_unset with the first query ' +
                 'parameter --' do
          let :new_request do
            request.query_unset 'q'
          end

          it 'should return a request with the same URI missing the first ' +
             'query parameter' do
            new_request.uri.should == URI.parse('https://njonsson@github.com' +
                                                ':123'                        +
                                                '/search/deep?lang=en#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #query_unset_all --' do
          let :new_request do
            request.query_unset_all
          end

          it 'should return a request with the same URI having no query ' +
             'string' do
            new_request.uri.should == URI.parse('https://'                +
                                                'njonsson@github.com:123' +
                                                '/search/deep#content')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #fragment_set with a different fragment --' do
          let :new_request do
            request.fragment_set 'details'
          end

          it 'should return a request with the same URI having the changed ' +
             'fragment' do
            new_request.uri.should == URI.parse('https://njonsson@github.com' +
                                                ':123'                        +
                                                '/search/deep?q=http&lang=en' +
                                                '#details')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #fragment_unset --' do
          let :new_request do
            request.fragment_unset
          end

          it 'should return a request with the same URI missing the fragment' do
            new_request.uri.should == URI.parse('https://'                +
                                                'njonsson@github.com:123' +
                                                '/search/deep?q=http&lang=en')
          end

          it 'should return a request without a response' do
            new_request.response.should be_nil
          end
        end

        describe '-- when sent #header_set with a new header' do
          let :new_request do
            request.header_set 'foo', 'bar'
          end

          it 'should return a request with an unchanged URI' do
            new_request.uri.should == URI.parse('https://'                    +
                                                'njonsson@github.com:123'     +
                                                '/search/deep?q=http&lang=en' +
                                                '#content')
          end

          it 'should return a request with no response' do
            new_request.response.should be_nil
          end

          describe '--' do
            it 'should return a request with the header, plus the default ' +
               'headers' do
              new_request.headers.should == [['User-Agent',    'htty/' +
                                                               HTTY::VERSION],
                                             ['Authorization', 'Basic ' +
                                                               'bmpvbnNzb24='],
                                             ['foo',           'bar']]
            end

            it 'should return a request without a response' do
              new_request.response.should be_nil
            end
          end

          describe 'and then #header_unset' do
            describe 'with the same header name --' do
              let :new_request do
                request.header_unset 'foo'
              end

              it 'should return a request with only the default headers' do
                new_request.headers.should == [['User-Agent',    'htty/' +
                                                                 HTTY::VERSION],
                                               ['Authorization', 'Basic '     +
                                                                 'bmpvbnNzb2' +
                                                                 '4=']]
              end
            end
          end

          describe 'and then #headers_unset_all --' do
            let :new_request do
              request.headers_unset_all
            end

            it 'should return a request with no headers' do
              new_request.headers.should be_empty
            end
          end
        end

        describe '-- when sent #body_set with a body' do
          let :new_request do
            request.body_set 'foo'
          end

          it 'should return a request with an unchanged URI' do
            new_request.uri.should == URI.parse('https://'                    +
                                                'njonsson@github.com:123'     +
                                                '/search/deep?q=http&lang=en' +
                                                '#content')
          end

          it 'should return a request with no response' do
            new_request.response.should be_nil
          end

          describe '--' do
            it 'should return a request with the body' do
              new_request.body.should == 'foo'
            end

            it 'should return a request with only the default headers' do
              new_request.headers.should == [['User-Agent',    'htty/' +
                                                               HTTY::VERSION],
                                             ['Authorization', 'Basic '     +
                                                               'bmpvbnNzb2' +
                                                               '4=']]
            end

            it "should return a request with the expected 'Content-Length' " +
               "header, plus the 'User-Agent' header if we do not exclude "  +
               "the 'Content-Length' header" do
              new_request.headers(true).should == [['User-Agent',    'htty/' +
                                                                     HTTY::VERSION],
                                                   ['Authorization', 'Basic ' +
                                                                     'bmpvbn' +
                                                                     'Nzb24='],
                                                   ['Content-Length', '3']]
            end

            it 'should return a request without a response' do
              new_request.response.should be_nil
            end
          end

          describe 'and then #body_unset' do
            let :new_request do
              request.body_unset
            end

            it 'should return a request with no body' do
              new_request.body.should be_nil
            end

            it 'should return a request with only the default headers' do
              new_request.headers.should == [['User-Agent',    'htty/' +
                                                               HTTY::VERSION],
                                             ['Authorization', 'Basic '     +
                                                               'bmpvbnNzb2' +
                                                               '4=']]
            end
          end
        end
      end
    end
  end
end
