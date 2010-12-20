require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_set")

describe HTTY::CLI::Commands::BodySet do
  before :each do
    instance.stub! :puts
    Readline.stub!(:readline).and_return nil
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

  it 'should receive multiline input from the command line' do
    Readline.should_receive(:readline).with().and_return "foo\n"
    Readline.should_receive(:readline).with().and_return "bar\n"
    Readline.should_receive(:readline).with().and_return "\n"
    Readline.should_receive(:readline).with().and_return "\n"
    instance.perform
  end

  it "should set the current requests's body from the input" do
    Readline.unstub! :readline
    Readline.stub!(:readline).and_return "foo\n", "bar\n", "\n"
    instance.perform
    session.requests.last.body.should == "foo\nbar"
  end
end
