require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/form_remove")

describe HTTY::CLI::Commands::FormRemove do
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
      klass.category.should == 'Building Requests'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'form-remove'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == "(Help for \e[1mform-remove\e[0m is not available)"
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == "(Help for \e[1mform-remove\e[0m is not " +
                                    'available).'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == []
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('form-remove', :session => :the_session)
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
