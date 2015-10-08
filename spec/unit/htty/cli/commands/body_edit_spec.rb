require 'htty/cli/commands/body_edit'
require 'htty/cli/commands/body_request'
require 'htty/cli/commands/body_set'
require 'htty/cli/commands/body_unset'
require 'unit/htty/cli/commands/shared_examples_for_commands'

RSpec.describe HTTY::CLI::Commands::BodyEdit do
  it_behaves_like 'a command' do
    let(:alias_for) {nil}
    let(:aliases) {[]}
    let(:arguments) {nil}
    let(:category) {'Building Requests'}
    let(:command_line) {'body-e[dit]'}
    let(:see_also_commands) {[
      HTTY::CLI::Commands::BodyRequest,
      HTTY::CLI::Commands::BodyUnset,
      HTTY::CLI::Commands::BodySet
    ]}
  end
end
