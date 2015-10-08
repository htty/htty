require 'htty/cli/commands/cookies_remove'
require 'htty/cli/commands/cookie_remove'
require 'htty/cli/commands/cookies'
require 'htty/cli/commands/cookies_add'
require 'htty/cli/commands/cookies_remove_all'
require 'htty/cli/commands/cookies_use'

RSpec.describe HTTY::CLI::Commands::CookiesRemove do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([HTTY::CLI::Commands::CookieRemove])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Building Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('cookies-remove')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('NAME')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Removes from the request the last cookie having a particular name')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Removes a cookie used for the request. Does not communicate with the host.

Cookies are not required to have unique names. You can add multiple cookies with the same name, and they will be removed in last-in-first-out order.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::Cookies,
                                             HTTY::CLI::Commands::CookiesAdd,
                                             HTTY::CLI::Commands::CookiesRemoveAll,
                                             HTTY::CLI::Commands::CookiesUse])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('cookies-remove foo', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['foo'])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x bar', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
