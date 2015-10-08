require 'htty/cli/commands/query_unset'
require 'htty/cli/commands/address'
require 'htty/cli/commands/query_add'
require 'htty/cli/commands/query_remove'
require 'htty/cli/commands/query_set'
require 'htty/cli/commands/query_unset_all'

RSpec.describe HTTY::CLI::Commands::QueryUnset do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Navigation')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('query-unset')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('NAME [VALUE]')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Removes query-string parameters from the ' +
                               "request's address")
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Removes one or more a query-string parameters used for the request. Does not communicate with the host.

The difference between this command and \e[1mquery-r[emove]\e[0m is that this command removes all matching parameters instead of removing matches one at a time from the end of the address.

The name of the query-string parameter will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::QuerySet,
                                             HTTY::CLI::Commands::QueryUnsetAll,
                                             HTTY::CLI::Commands::QueryAdd,
                                             HTTY::CLI::Commands::QueryRemove,
                                             HTTY::CLI::Commands::Address])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-unset foo bar', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(%w(foo bar))
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x baz qux', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
