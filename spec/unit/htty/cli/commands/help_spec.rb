require 'htty/cli/commands/help'

RSpec.describe HTTY::CLI::Commands::Help do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq(nil)
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('hel[p]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('[COMMAND]')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays this help table, or help on the ' +
                               'specified command')
    end

    it 'should have the expected help_extended' do
      expect(klass.help_extended).to eq('Displays a table containing available '   +
                                        'commands and a brief description of '     +
                                        'each, or detailed help on the specified ' +
                                        'command.')
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('help foo', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['foo'])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('hel', :session => :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
