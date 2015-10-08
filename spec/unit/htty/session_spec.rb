require 'htty/session'
require 'htty/request'

RSpec.describe HTTY::Session do
  it 'should have one request with the expected URI' do
    session = HTTY::Session.new('foo')
    expect(session.requests).to eq([HTTY::Request.new('foo')])
  end
end
