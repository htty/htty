require 'htty/cli/commands/query_add'
require 'htty/session'

RSpec.describe HTTY::CLI::Commands::QueryAdd do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'without an argument' do
    it 'should raise an error' do
      expect{instance.perform}.to raise_error(ArgumentError)
    end
  end

  describe 'with key argument only' do
    describe 'without key already present' do
      it 'should add key' do
        instance('test').perform
        expect(session.requests.last.uri.query).to eq('test')
      end
    end

    describe 'with key already present' do
      it 'should add key' do
        session.requests.last.uri.query = 'test=true'
        instance('test').perform
        expect(session.requests.last.uri.query).to eq('test=true&test')
      end
    end
  end

  describe 'with key and value arguments' do
    describe 'without key already present' do
      it 'should add key and value' do
        instance('test', 'true').perform
        expect(session.requests.last.uri.query).to eq('test=true')
      end
    end

    describe 'with key already present' do
      it 'should add key and value' do
        session.requests.last.uri.query = 'test=true'
        instance('test', 'false').perform
        expect(session.requests.last.uri.query).to eq('test=true&test=false')
      end
    end
  end
end
