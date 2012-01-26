require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_clear")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_unset_all")

describe HTTY::CLI::Commands::QueryUnsetAll do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == [HTTY::CLI::Commands::QueryClear]
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Navigation'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'query-unset-[all]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == "Clears the query string of the request's address"
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Clears the query string used for the request. Does not communicate with the host.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::QueryUnset,
                                         HTTY::CLI::Commands::QuerySet,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('query-unset-all', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('query-unset-', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        built.should == nil
      end
    end
  end
end
