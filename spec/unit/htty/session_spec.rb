require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/session")

describe HTTY::Session do
  it 'should have one request with the expected URI' do
    session = HTTY::Session.new('foo')
    session.requests.should == [HTTY::Request.new('foo')]
  end
end
