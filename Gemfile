source 'http://rubygems.org'

gemspec

gem     'jruby-openssl',           '~> 0', :platforms => :jruby
if RUBY_VERSION.to_s.start_with?( '1.8' )
  gem   'mime-types',              '~> 1'
else
  gem   'mime-types',              '~> 2'
end

group :debug do
  gem   'ruby-debug',              '~> 0', :platforms => :mri_18
  gem   'ruby-debug19',            '~> 0', :platforms => :mri_19, :require => 'ruby-debug'
end

group :development do
  gem 'codeclimate-test-reporter', '~> 0', :platforms => :mri_20, :require => false
end

group :doc do
  gem   'yard',                    '~> 0', :platforms => [:ruby, :mswin, :mingw]
  gem   'rdiscount',                       :platforms => [:ruby, :mswin, :mingw]
end

group :tooling do
  gem   'guard-rspec',   '~> 3'
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent',    '~> 0',                                  :require => false
  end
end
