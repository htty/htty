$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'webmock/cucumber'
require 'fileutils'
require 'rspec/expectations'

Before do
  WebMock.disable_net_connect!
end
