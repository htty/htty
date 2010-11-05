require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

describe HTTY::CLI::Commands::QueryAdd do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  describe 'class' do
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
      klass.command_line.should == 'query-a[dd]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'NAME [VALUE [NAME [VALUE ...]]]'
    end

    it 'should have the expected help' do
      klass.help.should == "Adds query-string parameters to the request's " +
                           'address'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Adds one or more query-string parameters used for the request. Does not communicate with the host.

The difference between this command and \e[1mquery-s[et]\e[0m is that this command adds duplicate parameters instead of replacing any of them.

The name(s) and value(s) of the query-string parameter(s) will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::QueryRemove,
                                         HTTY::CLI::Commands::QuerySet,
                                         HTTY::CLI::Commands::QueryUnset,
                                         HTTY::CLI::Commands::QueryUnsetAll,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-add foo bar', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == %w(foo bar)
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('query-a baz', :session => :a_session)
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

  describe 'instance' do
    def instance(*arguments)
      klass.new :session => session, :arguments => arguments
    end

    describe 'with key argument only' do
      describe 'without key already present' do
        it 'should add key' do
          instance('test').perform
          session.requests.last.uri.query.should == 'test'
        end
      end

      describe 'with key already present' do
        it 'should add key' do
          session.requests.last.uri.query = 'test=true'
          instance('test').perform
          session.requests.last.uri.query.should == 'test=true&test'
        end
      end
    end

    describe 'with key and value arguments' do
      describe 'without key already present' do
        it 'should add key and value' do
          instance('test', 'true').perform
          session.requests.last.uri.query.should == 'test=true'
        end
      end

      describe 'with key already present' do
        it 'should add key and value' do
          session.requests.last.uri.query = 'test=true'
          instance('test', 'false').perform
          session.requests.last.uri.query.should == 'test=true&test=false'
        end
      end
    end
  end
end
