require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history_verbose")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/reuse")

describe HTTY::CLI::Commands::History do
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
      klass.command_line.should == 'history'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays previous request-response activity in ' +
                           'this session'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays previous request-response activity in this session. Does not communicate with the host.

Only a summary of each request-response pair is shown; the contents of headers and bodies are hidden.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::HistoryVerbose,
                                         HTTY::CLI::Commands::Reuse]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('history', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        built.should == nil
      end
    end
  end
end
