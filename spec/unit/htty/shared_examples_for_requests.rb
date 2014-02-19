shared_examples_for 'an empty request' do
  it 'should have only the default headers' do
    request.headers.should == [
      ['User-Agent', "htty/#{HTTY::VERSION}"]
    ]
  end

  it 'should have no body' do
    request.body.should be_nil
  end

  it 'should have no response' do
    request.response.should be_nil
  end
end

shared_examples_for 'an empty, authenticated request' do
  it 'should the expected Authorization header plus the default headers' do
    request.headers.should == [
      ['User-Agent', "htty/#{HTTY::VERSION}"],
      HTTY::Headers.basic_authentication_for(username, password)
    ]
  end

  it 'should have no body' do
    request.body.should be_nil
  end

  it 'should have no response' do
    request.response.should be_nil
  end
end
