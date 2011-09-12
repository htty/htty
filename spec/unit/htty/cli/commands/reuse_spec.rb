require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history_verbose")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/reuse")

describe HTTY::CLI::Commands::Reuse do
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
      klass.command_line.should == 'r[euse]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'INDEX'
    end

    it 'should have the expected help' do
      klass.help.should == 'Copies a previous request by the index number ' +
                           'shown in history'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Copies the properties of a previous request to be used for the request, using the request index number shown in history. Does not communicate with the host.

The argument is an index number that appears when you type \e[1mhistory\e[0m.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::History,
                                         HTTY::CLI::Commands::HistoryVerbose]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('reuse foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('r bar', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['bar']
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x baz', :session => :another_session)
        built.should == nil
      end
    end
  end
end
