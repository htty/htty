source 'http://rubygems.org'

gemspec

group :development do
  gem 'ruby-debug', :platforms => 'ruby_18'

  # This is a dependency of ruby-debug. We're specifying it here because its
  # v0.45 is incompatible with Ruby v1.8.7.
  gem 'linecache', '<= 0.43', :platforms => 'ruby_18'

  gem 'ruby-debug19', :platforms => 'ruby_19'
end
