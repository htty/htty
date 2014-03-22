require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/shared_examples_for_commands")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_edit")

describe HTTY::CLI::Commands::BodyEdit do
  it_behaves_like 'a command' do
    let(:alias_for) {nil}
    let(:aliases) {[]}
    let(:arguments) {nil}
    let(:category) {'Building Requests'}
    let(:command_line) {'body-e[dit]'}
    let(:see_also_commands) {[
      HTTY::CLI::Commands::BodyRequest,
      HTTY::CLI::Commands::BodySet,
      HTTY::CLI::Commands::BodyUnset
    ]}
  end
end
