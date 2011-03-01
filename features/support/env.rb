$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'fileutils'
require 'net/http'
require 'rspec/expectations'
require 'vcr'

Before do
  VCR.config do |c|
    c.cassette_library_dir = 'features/support/vcr_cassettes'
    c.stub_with :webmock
  end

  VCR.use_cassette('htty_github_com', :record => :new_episodes) do
    Net::HTTP.get_response URI.parse('http://htty.github.com/')
  end
end
