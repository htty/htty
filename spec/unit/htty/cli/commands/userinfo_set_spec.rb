require 'htty/cli/commands/userinfo_set'
require 'htty/cli/commands/address'
require 'htty/cli/commands/userinfo_unset'

RSpec.describe HTTY::CLI::Commands::UserinfoSet do
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
      expect(klass.category).to eq('Navigation')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('userinfo-s[et]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('USERNAME [PASSWORD]')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq("Sets the userinfo of the request's address")
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Sets the userinfo used for the request. Does not communicate with the host.

Userinfo will be URL-encoded if necessary.

When userinfo is set, a corresponding 'Authorization' header is set automatically.

The console prompt shows the address for the current request. Userinfo appears in normal type while the rest of the address appears in bold to indicate that userinfo is sent to the host in the form of a header.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::UserinfoUnset,
                                             HTTY::CLI::Commands::Address])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('userinfo-set foo bar', session: :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(%w(foo bar))
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('userinfo-s baz', session: :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['baz'])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x qux', session: :another_session)
        expect(built).to eq(nil)
      end
    end

    describe '#sanitize_arguments' do
      context 'when only one argument like username:password' do
        let(:arguments) {['username:password']}

        it 'should be splitted in two arguments' do
          expect(klass.sanitize_arguments(arguments)).to eq(%w(username
                                                               password))
        end
      end

      context 'when arguments contains special characters' do
        let(:arguments) {['user/name', 'password']}

        it 'should escape them' do
          expect(klass.sanitize_arguments(arguments)).to eq(%w(user%2Fname
                                                               password))
        end
      end
    end
  end
end
