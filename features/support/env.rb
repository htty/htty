$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'webmock/cucumber'
require 'fileutils'
require 'rspec/expectations'

Before do
  stub_request(:get, 'htty.github.com').to_return File.new(File.dirname(__FILE__) + '/htty_page')
  WebMock.disable_net_connect!
  WebMock.reset!
end
