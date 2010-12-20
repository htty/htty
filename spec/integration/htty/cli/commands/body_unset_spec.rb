require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_unset")

describe HTTY::CLI::Commands::BodyUnset do
  before :each do
    session.requests.last.body_set 'foo'
  end

  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  let :instance do
    klass.new :session => session
  end

  it "should clear the current request's body" do
    session.requests.last.body.should_not == nil
    instance.perform
    session.requests.last.body.should == nil
  end
end
