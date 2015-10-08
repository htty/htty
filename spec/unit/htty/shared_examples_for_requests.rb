require 'htty/headers'
require 'htty/version'

RSpec.shared_examples_for 'an empty request' do
  it 'should have only the default headers' do
    expect(request.headers).to eq([%W(User-Agent htty/#{HTTY::VERSION})])
  end

  it 'should have no body' do
    expect(request.body).to be_nil
  end

  it 'should have no response' do
    expect(request.response).to be_nil
  end
end

RSpec.shared_examples_for 'an empty, authenticated request' do
  it 'should the expected Authorization header plus the default headers' do
    expect(request.headers).to eq([%W(User-Agent htty/#{HTTY::VERSION}),
                                   HTTY::Headers.basic_authentication_for(username,
                                                                          password)])
  end

  it 'should have no body' do
    expect(request.body).to be_nil
  end

  it 'should have no response' do
    expect(request.response).to be_nil
  end
end
