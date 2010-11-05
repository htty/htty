require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

describe HTTY::CLI::Commands::QuerySet do
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

  describe 'instance' do
    def instance(*arguments)
      klass.new :session => session, :arguments => arguments
    end

    describe 'with one argument' do
      it 'should assign a single key' do
        instance('test').perform
        session.requests.last.uri.query.should == 'test'
      end
    end

    describe 'with two arguments' do
      it 'should assign a key-value pair' do
        instance('test', 'true').perform
        session.requests.last.uri.query.should == 'test=true'
      end
    end

    describe 'with three arguments' do
      it 'should assign a key-value pair and a valueless key' do
        instance('test', 'true', 'more').perform
        session.requests.last.uri.query.should == 'test=true&more'
      end
    end

    describe 'with four arguments' do
      it 'should assign two key-value pairs' do
        instance('test', 'true', 'more', 'false').perform
        session.requests.last.uri.query.should == 'test=true&more=false'
      end
    end

    describe 'with duplicate keys' do
      it 'should replace existing key' do
        session.requests.last.uri.query = 'test=true'
        instance('test', 'false').perform
        session.requests.last.uri.query.should == 'test=false'
      end

      it 'should maintain field location' do
        session.requests.last.uri.query = 'test=true&more=true'
        instance('test', 'false').perform
        session.requests.last.uri.query.should == 'test=false&more=true'
      end

      it 'should replace multiple instances with one' do
        session.requests.last.uri.query = 'test=true&more=true&test=true'
        instance('test', 'false').perform
        session.requests.last.uri.query.should == 'test=false&more=true'
      end

      it 'should play nice with nested fields' do
        session.requests.last.uri.query = 'test[my][]=1'
        instance('test[my][]', '2').perform
        instance('test', '3').perform
        session.requests.last.uri.query.should == 'test[my][]=2&test=3'
      end
    end
  end
end
