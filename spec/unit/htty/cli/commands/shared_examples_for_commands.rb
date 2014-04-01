require 'spec_helper'

shared_examples_for 'a command' do
  it 'should be an alias_for the expected command' do
    described_class.alias_for.should == alias_for
  end

  it 'should have the expected aliases' do
    described_class.aliases.should == aliases
  end

  it 'should belong to the expected category' do
    described_class.category.should == category
  end

  it 'should have the expected command_line' do
    described_class.command_line.should == command_line
  end

  it 'should have the expected command_line_arguments' do
    described_class.command_line_arguments.should == arguments
  end

  it 'should have the expected help' do
    described_class.help.should_not be_empty
  end

  it 'should have the expected help_extended' do
    described_class.help_extended.should be_multiline
  end

  it 'should have the expected see_also_commands' do
    described_class.see_also_commands.should =~ see_also_commands
  end

  describe 'build_for' do
    it 'should correctly handle a valid, unabbreviated command line' do
      command_used = command_line.tr('[]', '')
      built = described_class.build_for(command_used, :session => :the_session)
      built.should be_instance_of(described_class)
      built.arguments.should == []
      built.session.should == :the_session
    end

    it 'should correctly handle a valid, abbreviated command line' do
      if command_line.match /^(.*)\[(.*?)\]$/
        command_used = $1 + $2[0, rand($2.length)+1]
        built = described_class.build_for(command_used, :session => :the_session)
        built.should be_instance_of(described_class)
        built.arguments.should == []
        built.session.should == :the_session
      end
    end
  end
end
