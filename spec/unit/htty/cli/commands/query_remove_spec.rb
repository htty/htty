require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")

describe HTTY::CLI::Commands::QueryRemove do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new ''
  end

  describe 'with existing query string with duplicate keys set' do
    before :each do
      session.requests.last.uri.query = 'test=true&test=false'
    end

    describe 'with only key specified' do
      it 'should remove last entry' do
        query_remove = create_query_remove_and_perform('test')
        query_remove.session.requests.last.uri.query.should == 'test=true'
      end
    end

    describe 'with key and value specified' do
      it 'should remove matching entry only' do
        query_remove = create_query_remove_and_perform('test', 'true')
        query_remove.session.requests.last.uri.query.should == 'test=false'
      end
    end
  end

  def create_query_remove_and_perform(*arguments)
    query_remove = HTTY::CLI::Commands::QueryRemove.new(:session => session,
                                                        :arguments => arguments)
    query_remove.perform
    query_remove
  end

end
