require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/exit")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/quit")

describe HTTY::CLI::Commands::Quit do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == [HTTY::CLI::Commands::Exit]
    end

    it 'should belong to the expected category' do
      klass.category.should == nil
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'qui[t]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Quits htty'
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == 'Quits htty.'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == []
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('quit', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('qui', :session => :a_session)
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
