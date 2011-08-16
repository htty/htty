require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = File.expand_path("#{File.dirname __FILE__}/vcr_cassettes")
  c.stub_with :webmock
end
