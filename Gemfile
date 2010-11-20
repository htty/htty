source 'http://rubygems.org'

gem 'rake'

group :development do
  gem 'autotest'
  gem 'autotest-fsevent'
  gem (RUBY_VERSION =~ /^1.9/) ? 'ruby-debug19' : 'ruby-debug'
end

group :doc do
  gem 'bluecloth'
  gem 'yard'
end

group :spec do
  gem 'rspec'
end
