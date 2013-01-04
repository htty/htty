require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/help")

describe HTTY::CLI::Commands::Help do
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
      klass.category.should == nil
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'hel[p]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == '[COMMAND]'
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays this help table, or help on the ' +
                           'specified command'
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == 'Displays a table containing available '   +
                                    'commands and a brief description of '     +
                                    'each, or detailed help on the specified ' +
                                    'command.'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == []
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('help foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('hel', :session => :a_session)
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
