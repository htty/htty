require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")

describe HTTY::CLI::Commands::QuerySet do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with one argument' do
    it 'should assign a single key' do
      instance('test').perform
      session.requests.last.uri.query.should == 'test'
    end
  end

  describe 'with two arguments' do
    it 'should assign a key-value pair' do
      instance('test', 'true').perform
      session.requests.last.uri.query.should == 'test=true'
    end
  end

  describe 'with three arguments' do
    it 'should assign a key-value pair and a valueless key' do
      instance('test', 'true', 'more').perform
      session.requests.last.uri.query.should == 'test=true&more'
    end
  end

  describe 'with four arguments' do
    it 'should assign two key-value pairs' do
      instance('test', 'true', 'more', 'false').perform
      session.requests.last.uri.query.should == 'test=true&more=false'
    end
  end

  describe 'with duplicate keys' do
    it 'should replace existing key' do
      session.requests.last.uri.query = 'test=true'
      instance('test', 'false').perform
      session.requests.last.uri.query.should == 'test=false'
    end

    it 'should maintain field location' do
      session.requests.last.uri.query = 'test=true&more=true'
      instance('test', 'false').perform
      session.requests.last.uri.query.should == 'test=false&more=true'
    end

    it 'should replace multiple instances with one' do
      session.requests.last.uri.query = 'test=true&more=true&test=true'
      instance('test', 'false').perform
      session.requests.last.uri.query.should == 'test=false&more=true'
    end

    it 'should play nice with nested fields' do
      session.requests.last.uri.query = 'test[my][]=1'
      instance('test[my][]', '2').perform
      instance('test', '3').perform
      session.requests.last.uri.query.should == 'test[my][]=2&test=3'
    end
  end
end
