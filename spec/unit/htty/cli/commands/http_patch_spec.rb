require 'htty/cli/commands/http_patch'
require 'htty/cli/commands/follow'
require 'htty/cli/commands/http_delete'
require 'htty/cli/commands/http_get'
require 'htty/cli/commands/http_post'
require 'htty/cli/commands/http_put'
require 'htty/cli/commands/patch'

RSpec.describe HTTY::CLI::Commands::HttpPatch do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([HTTY::CLI::Commands::Patch])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Issuing Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('http-pa[tch]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Issues an HTTP PATCH using the current request')
    end

    it 'should have the expected help_extended' do
      expect(klass.help_extended).to eq('Issues an HTTP PATCH using the current ' +
                                        'request.')
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::HttpGet,
                                             HTTY::CLI::Commands::Follow,
                                             HTTY::CLI::Commands::HttpPost,
                                             HTTY::CLI::Commands::HttpPut,
                                             HTTY::CLI::Commands::HttpDelete])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('http-patch', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('http-pa', :session => :a_session)
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
