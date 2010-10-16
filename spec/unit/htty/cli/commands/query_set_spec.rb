require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli")

describe HTTY::CLI::Commands::QuerySet do
  before :all do
    @session = HTTY::Session.new('')
  end

  describe 'with one argument' do
    it 'should assign a single key' do
      query_set = create_query_set_and_perform('test')
      query_set.session.requests.last.uri.query.should == 'test'
    end
  end

  describe 'with two arguments' do
    it 'should assign a key-value pair' do
      query_set = create_query_set_and_perform('test', 'true')
      query_set.session.requests.last.uri.query.should == 'test=true'
    end
  end

  describe 'with three arguments' do
    it 'should assign a key-value pair and a valueless key' do
      query_set = create_query_set_and_perform('test', 'true', 'more')
      query_set.session.requests.last.uri.query.should == 'test=true&more'
    end
  end

  describe 'with four arguments' do
    it 'should assign two key-value pairs' do
      query_set = create_query_set_and_perform('test', 'true', 'more', 'false')
      query_set.session.requests.last.uri.query.should == 'test=true&more=false'
    end
  end

  describe 'with duplicate keys' do
    it 'should replace existing key' do
      @session.requests.last.uri.query = 'test=true'
      query_set = create_query_set_and_perform('test', 'false')
      query_set.session.requests.last.uri.query.should == 'test=false'
    end

    it 'should maintain field location' do
      @session.requests.last.uri.query = 'test=true&more=true'
      query_set = create_query_set_and_perform('test', 'false')
      query_set.session.requests.last.uri.query.should == 'test=false&more=true'
    end

    it 'should replace multiple instances with one' do
      @session.requests.last.uri.query = 'test=true&more=true&test=true'
      query_set = create_query_set_and_perform('test', 'false')
      query_set.session.requests.last.uri.query.should == 'test=false&more=true'
    end

    it 'should play nice with nested fields' do
      @session.requests.last.uri.query = 'test[my][]=1'
      query_set = create_query_set_and_perform('test[my][]', '2')
      query_set = create_query_set_and_perform('test', '3')
      query_set.session.requests.last.uri.query.should == 'test[my][]=2&test=3'
    end
  end

  def create_query_set_and_perform(*arguments)
    query_set = HTTY::CLI::Commands::QuerySet.new(:session => @session,
                                                  :arguments => arguments)
    query_set.perform
    query_set
  end

end
