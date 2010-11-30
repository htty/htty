require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

describe HTTY::CLI::Commands::QuerySet do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == []
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Navigation'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'query-s[et]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'NAME [VALUE [NAME [VALUE ...]]]'
    end

    it 'should have the expected help' do
      klass.help.should == "Sets query-string parameters in the request's " +
                           'address'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Sets one or more query-string parameters used for the request. Does not communicate with the host.

The difference between this command and \e[1mquery-a[dd]\e[0m is that this command replaces any duplicate parameters instead of adding more.

The name(s) and value(s) of the query-string parameter(s) will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::QueryUnset,
                                         HTTY::CLI::Commands::QueryUnsetAll,
                                         HTTY::CLI::Commands::QueryAdd,
                                         HTTY::CLI::Commands::QueryRemove,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-set foo bar', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == %w(foo bar)
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('query-s baz', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['baz']
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x qux', :session => :another_session)
        built.should == nil
      end
    end
  end
end
