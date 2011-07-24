require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'features/support/vcr_cassettes'
  c.stub_with :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@request'
end
