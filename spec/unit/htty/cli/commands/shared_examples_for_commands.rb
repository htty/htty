RSpec.shared_examples_for 'a command' do
  it 'should be an alias_for the expected command' do
    expect(described_class.alias_for).to eq(alias_for)
  end

  it 'should have the expected aliases' do
    expect(described_class.aliases).to eq(aliases)
  end

  it 'should belong to the expected category' do
    expect(described_class.category).to eq(category)
  end

  it 'should have the expected command_line' do
    expect(described_class.command_line).to eq(command_line)
  end

  it 'should have the expected command_line_arguments' do
    expect(described_class.command_line_arguments).to eq(arguments)
  end

  it 'should have the expected help' do
    expect(described_class.help).not_to be_empty
  end

  it 'should have the expected help_extended' do
    expect(described_class.help_extended).to be_multiline
  end

  it 'should have the expected see_also_commands' do
    expect(described_class.see_also_commands).to match( see_also_commands )
  end

  describe 'build_for' do
    it 'should correctly handle a valid, unabbreviated command line' do
      command_used = command_line.tr('[]', '')
      built = described_class.build_for(command_used, session: :the_session)
      expect(built).to be_instance_of(described_class)
      expect(built.arguments).to eq([])
      expect(built.session).to eq(:the_session)
    end

    it 'should correctly handle a valid, abbreviated command line' do
      if command_line =~ /^(.*)\[(.*?)\]$/
        command_used = $1 + $2[0, rand($2.length)+1]
        built = described_class.build_for(command_used, session: :the_session)
        expect(built).to be_instance_of(described_class)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end
    end
  end
end
