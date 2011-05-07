require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_clear")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_remove")

describe HTTY::CLI::Commands::MultipartRemove do
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
      klass.command_line.should == 'multipart-r[emove]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'NAME [NAME [NAME ...]]'
    end

    it 'should have the expected help' do
      klass.help.should == 'Removes one or more parts from request'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Removes one or more parts from request body. Does not communicate with the host.

      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::MultipartSet, HTTY::CLI::Commands::MultipartClear]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('multipart-remove foo bar', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == %w(foo bar)
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('multipart-r baz', :session => :a_session)
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
end
