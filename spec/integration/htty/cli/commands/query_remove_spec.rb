require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")

describe HTTY::CLI::Commands::QueryRemove do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with existing query string with only one key and value' do
    before :each do
      session.requests.last.uri.query = 'test=true'
    end

    describe 'with only key in query string' do
      it 'should empty the query string' do
        instance('test').perform
        session.requests.last.uri.query.should be_nil
      end

      it 'should not leave a trailing question mark' do
        instance('test').perform
        session.requests.last.uri.to_s.should_not end_with('?')
      end
    end
  end

  describe 'with existing query string with duplicate keys set' do
    before :each do
      session.requests.last.uri.query = 'test=true&test=false'
    end

    describe 'with only key specified' do
      it 'should remove last entry' do
        instance('test').perform
        session.requests.last.uri.query.should == 'test=true'
      end
    end

    describe 'with key and value specified' do
      it 'should remove matching entry only' do
        instance('test', 'true').perform
        session.requests.last.uri.query.should == 'test=false'
      end
    end
  end
end
