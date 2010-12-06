require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/navigation_command_sharedspec")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")

describe HTTY::CLI::Commands::Address do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def create_instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with a valid HTTP address' do
    let :instance do
      create_instance 'http://1.2.3.4:5678'
    end

    it_should_behave_like 'a navigation command'

    it "should set the current request's URI as expected when performed" do
      instance.perform
      session.requests.last.uri.to_s.should == 'http://1.2.3.4:5678/'
    end
  end

  describe 'with a valid HTTP Secure address' do
    let :instance do
      create_instance 'https://github.com/htty/htty#readme'
    end

    it_should_behave_like 'a navigation command'

    it "should set the current request's URI as expected when performed" do
      instance.perform
      session.requests.last.uri.to_s.should == 'https://github.com/htty/htty' +
                                               '#readme'
    end
  end

  describe 'with a valid FTP address' do
    let :instance do
      create_instance 'ftp://myftpsite.info'
    end

    it 'should raise the expected error when performed' do
      expect do
        instance.perform
      end.to raise_error(ArgumentError,
                         'only "http://" and "https://" addresses are ' +
                         'supported')
    end
  end

  describe 'without arguments' do
    let :instance do
      create_instance
    end

    it 'should raise the expected error when performed' do
      expect do
        instance.perform
      end.to raise_error(ArgumentError, 'wrong number of arguments (0 for 1)')
    end
  end
end
