source 'https://rubygems.org'

gemspec

group :debug do
  gem   'pry-byebug',                '~> 3',                    :platforms => [:mri_20,
                                                                               :mri_21,
                                                                               :mri_22]
  gem   'pry-debugger',              '~> 0',                    :platforms => [:mri_18,
                                                                               :mri_19]
end

group :development do
  if RUBY_VERSION.start_with?('1.8')
    gem 'codeclimate-test-reporter', '> 0', '< 0.4.2',
                                             :require => false
  else
    gem 'codeclimate-test-reporter', '~> 0', :require => false
  end
end

group :doc do
  gem   'yard',                      '~> 0', :require => false
  gem   'rdiscount',                 '~> 2', :require => false
end

group :tooling do
  gem   'guard-rspec',               '~> 4', :require => false, :platforms => [:mri_19,
                                                                               :mri_20,
                                                                               :mri_21,
                                                                               :mri_22]
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent',                '~> 0', :require => false, :platforms => [:mri_19,
                                                                               :mri_20,
                                                                               :mri_21,
                                                                               :mri_22]
  end
end
