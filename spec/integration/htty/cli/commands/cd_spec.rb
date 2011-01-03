require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cd")

describe HTTY::CLI::Commands::Cd do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with existing path' do
    before :each do
      session.requests.last.uri.path = '/foo/bar'
    end

    it_should_behave_like 'a navigation command'

    it 'should correctly handle relative paths' do
      instance( 'baz' ).perform
      session.requests.last.uri.path.should == '/foo/bar/baz'
    end

    it 'should correctly handle relative paths with parents' do
      instance( '../../baz' ).perform
      session.requests.last.uri.path.should == '/baz'
    end

    it 'should correctly handle absolute paths' do
      instance( '/baz/qux' ).perform
      session.requests.last.uri.path.should == '/baz/qux'
    end
  end
end
