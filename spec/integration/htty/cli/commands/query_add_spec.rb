require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")

describe HTTY::CLI::Commands::QueryAdd do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with key argument only' do
    describe 'without key already present' do
      it 'should add key' do
        instance('test').perform
        session.requests.last.uri.query.should == 'test'
      end
    end

    describe 'with key already present' do
      it 'should add key' do
        session.requests.last.uri.query = 'test=true'
        instance('test').perform
        session.requests.last.uri.query.should == 'test=true&test'
      end
    end
  end

  describe 'with key and value arguments' do
    describe 'without key already present' do
      it 'should add key and value' do
        instance('test', 'true').perform
        session.requests.last.uri.query.should == 'test=true'
      end
    end

    describe 'with key already present' do
      it 'should add key and value' do
        session.requests.last.uri.query = 'test=true'
        instance('test', 'false').perform
        session.requests.last.uri.query.should == 'test=true&test=false'
      end
    end
  end
end
