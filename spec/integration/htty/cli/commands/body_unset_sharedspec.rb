require 'rspec'

shared_examples_for "the 'body-unset' command" do
  before :each do
    session.requests.last.body_set 'foo'
  end

  it "should clear the current request's body" do
    session.requests.last.body.should_not == nil
    instance.perform
    session.requests.last.body.should == nil
  end
end
