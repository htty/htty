source 'https://rubygems.org'

gemspec

group :debug do
  gem   'pry-byebug',  '~> 3'
end

group :doc do
  gem   'yard',        '~> 0', require: false
  gem   'rdiscount',   '~> 2', require: false
end

group :tooling do
  gem   'guard-rspec', '~> 4', require: false
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent',  '~> 0', require: false
  end
end
