require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/fragment_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/fragment_unset")

describe HTTY::CLI::Commands::FragmentSet do
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
      klass.command_line.should == 'fragment-s[et]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'FRAGMENT'
    end

    it 'should have the expected help' do
      klass.help.should == "Sets the fragment of the request's address"
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Sets the page fragment used for the request. Does not communicate with the host.

The page fragment will be URL-encoded if necessary.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::FragmentUnset,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('fragment-set foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('fragment-s bar', :session => :a_session)
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
