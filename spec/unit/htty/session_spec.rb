require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/session")

describe HTTY::Session do
  before :each do
    @session = HTTY::Session.new('foo')
  end

  it 'should have one request with the expected URI' do
    @session.requests.should == [HTTY::Request.new('foo')]
  end
end
