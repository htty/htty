require 'fileutils'

BIN_FILE        = File.expand_path("#{File.dirname __FILE__}/../bin/htty")
BIN_FILE_BACKUP = "#{BIN_FILE}.backup"

def hack_htty_to_use_vcr_cassette(name)
  FileUtils.cp BIN_FILE, BIN_FILE_BACKUP
  source_lines = File.read(BIN_FILE).split("\n")
  shebang = source_lines.index do |l|
    l =~ /^#!/
  end
  shebang ||= 0
  vcr_config = File.expand_path("#{File.dirname __FILE__}/support/vcr")
  source_lines.insert(shebang + 1, '',
                                   "require 'rubygems'",
                                   "require #{vcr_config.inspect}",
                                   "VCR.insert_cassette #{name.inspect}",
                                   'begin',
                                   '  ### BEGIN HTTY SOURCE ###')
  source_lines << ''
  source_lines << '  ### END HTTY SOURCE ###'
  source_lines << 'ensure'
  source_lines << '  VCR.eject_cassette'
  source_lines << 'end'
  File.open BIN_FILE, 'w' do |f|
    source_lines.each do |l|
      f.puts l
    end
  end
end

After do
  FileUtils.mv BIN_FILE_BACKUP, BIN_FILE if File.file?(BIN_FILE_BACKUP)
end

Given 'an htty session' do
  Given 'I run "htty" interactively'
end

Given /^an htty session with (.+)$/ do |address|
  hack_htty_to_use_vcr_cassette address
  Given %Q{I run "htty #{address}" interactively}
end

Then 'I should see the 200 OK output' do
  Then 'the output should match:',
       '200.+? OK -- \d+ headers? -- \d+-character body'
end

Then 'I should see the goodbye output' do
  Then 'the output should contain:', '*** Happy Trails To You!'
end
