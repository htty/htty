require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/response")

shared_examples_for 'a navigation command' do
  before :each do
    session.requests.last.stub!(:response).and_return HTTY::Response.new
  end

  it 'should add a new request to the session when sent #perform' do
    lambda {
      instance.perform
    }.should change(session.requests, :length).by(1)
  end
end
