require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

describe HTTY::CLI::Commands::QueryRemove do
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
      klass.command_line.should == 'query-r[emove]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'NAME [VALUE]'
    end

    it 'should have the expected help' do
      klass.help.should == 'Removes query-string parameters from the end of ' +
                           "the request's address"
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Removes one or more a query-string parameters used for the request. Does not communicate with the host.

The difference between this command and \e[1mquery-unset\e[0m is that this command removes matching parameters one at a time from the end of the address instead of removing all matches.

The name and value of the query-string parameter will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::QueryAdd,
                                         HTTY::CLI::Commands::QuerySet,
                                         HTTY::CLI::Commands::QueryUnset,
                                         HTTY::CLI::Commands::QueryUnsetAll,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-remove foo bar', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == %w(foo bar)
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('query-r baz', :session => :a_session)
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
