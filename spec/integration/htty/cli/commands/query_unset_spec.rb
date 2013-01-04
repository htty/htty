require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")

describe HTTY::CLI::Commands::QueryUnset do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with existing query string with duplicate keys set' do
    before :each do
      session.requests.last.uri.query = 'test=true&test=false'
    end

    describe 'with only key specified' do
      it 'should remove all entries' do
        instance('test').perform
        session.requests.last.uri.query.should == ''
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
