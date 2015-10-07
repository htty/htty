require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

RSpec.describe HTTY::CLI::Commands::QueryAdd do
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
      expect(klass.command_line).to eq('query-a[dd]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('NAME [VALUE [NAME [VALUE ...]]]')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq("Adds query-string parameters to the request's " +
                               'address')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Adds one or more query-string parameters used for the request. Does not communicate with the host.

The difference between this command and \e[1mquery-s[et]\e[0m is that this command adds duplicate parameters instead of replacing any of them.

The name(s) and value(s) of the query-string parameter(s) will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::QueryRemove,
                                             HTTY::CLI::Commands::QuerySet,
                                             HTTY::CLI::Commands::QueryUnset,
                                             HTTY::CLI::Commands::QueryUnsetAll,
                                             HTTY::CLI::Commands::Address])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-add foo bar', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(%w(foo bar))
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('query-a baz', :session => :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['baz'])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x qux', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
