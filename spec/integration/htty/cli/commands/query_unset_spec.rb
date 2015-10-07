require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")

RSpec.describe HTTY::CLI::Commands::QueryUnset do
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
        expect(session.requests.last.uri.query).to be_nil
      end

      it 'should not leave a trailing question mark' do
        instance('test').perform
        expect(session.requests.last.uri.to_s).not_to end_with('?')
      end
    end

    describe 'with key and value specified' do
      it 'should remove matching entry only' do
        instance('test', 'true').perform
        expect(session.requests.last.uri.query).to eq('test=false')
      end
    end
  end
end
