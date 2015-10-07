require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/headers")
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/cli/display")

RSpec.describe HTTY::CLI::Display do
  let(:display) {Class.new.new.extend(HTTY::CLI::Display)}

  describe '#show_headers' do
    it 'displays headers keeping the text case' do
      headers = HTTY::Headers.new('user-agent' => 'htty/1.4.1').to_a

      expect {
        display.show_headers headers
      }.to print_on_stdout("user-agent:#{display.strong ''} htty/1.4.1\n")
    end

    context 'with one header' do
      let(:headers) {HTTY::Headers.new('User-Agent' => 'htty/1.4.1').to_a}

      it 'displays the header starting from the beginning of the line' do
        expect {
          display.show_headers headers
        }.to print_on_stdout("User-Agent:#{display.strong ''} htty/1.4.1\n")
      end
    end

    context 'with few headers' do
      let(:headers) {
        headers = HTTY::Headers.new
        headers['User-Agent'] = 'htty/1.4.1'
        headers['Content-Type'] = 'application/json'
        headers.to_a
      }

      it 'aligns headers on colons' do
        expect {
          display.show_headers headers
        }.to print_on_stdout <<-end_stdout
  User-Agent:#{display.strong ''} htty/1.4.1
Content-Type:#{display.strong ''} application/json
        end_stdout
      end
    end

    context 'with marked headers' do
      context 'with one header' do
        let(:headers) {HTTY::Headers.new('User-Agent' => 'htty/1.4.1').to_a}
        let(:options) {{:show_mercantile_next_to => 'User-Agent'}}

        it 'displays the header starting from the beginning of the line' do
          expect {
            display.show_headers headers, options
          }.to print_on_stdout("User-Agent:#{display.strong '@'} htty/1.4.1\n")
        end
      end

      context 'with few headers' do
        let(:options) {{:show_mercantile_next_to => 'Content-Type'}}
        let(:headers) {
          headers = HTTY::Headers.new
          headers['User-Agent'] = 'htty/1.4.1'
          headers['Content-Type'] = 'application/json'
          headers.to_a
        }

        it 'aligns colons and mercantiles' do
          expect {
            display.show_headers headers, options
          }.to print_on_stdout <<-end_stdout
   User-Agent:#{display.strong ''} htty/1.4.1
Content-Type:#{display.strong '@'} application/json
          end_stdout
        end
      end
    end

    context 'when asked to mark an header' do
      let(:options) {{:show_mercantile_next_to => 'Content-Type'}}
      let(:headers) {HTTY::Headers.new('content-type' => 'application/json').to_a}

      it 'marks headers indipendently of the text case' do
        expect {
          display.show_headers headers, options
        }.to print_on_stdout <<-end_stdout
content-type:#{display.strong '@'} application/json
        end_stdout
      end
    end
  end
end
