require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")

describe HTTY::CLI::Commands::QueryUnset do
  before :each do
    @session = HTTY::Session.new('')
  end

  describe 'with existing query string with duplicate keys set' do
    before :each do
      @session.requests.last.uri.query = 'test=true&test=false'
    end

    describe 'with only key specified' do
      it 'should remove all entries' do
        query_unset = create_query_unset_and_perform('test')
        query_unset.session.requests.last.uri.query.should == ''
      end
    end

    describe 'with key and value specified' do
      it 'should remove matching entry only' do
        query_unset = create_query_unset_and_perform('test', 'true')
        query_unset.session.requests.last.uri.query.should == 'test=false'
      end
    end
  end

  def create_query_unset_and_perform(*arguments)
    query_unset = HTTY::CLI::Commands::QueryUnset.new(:session => @session,
                                                      :arguments => arguments)
    query_unset.perform
    query_unset
  end
end
