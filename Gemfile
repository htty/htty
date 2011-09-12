source 'http://rubygems.org'

gemspec

gem 'jruby-openssl',          :platforms => :jruby

group :development do
  gem 'ruby-debug',           :platforms => :mri_18

  # This is a dependency of ruby-debug. We're specifying it here because its
  # v0.45 is incompatible with Ruby v1.8.7.
  gem 'linecache', '<= 0.43', :platforms => :mri_18

  gem 'ruby-debug19',         :platforms => :mri_19

  gem 'yard',                 :platforms => [:ruby, :mswin, :mingw]
  gem 'rdiscount',            :platforms => [:ruby, :mswin, :mingw]
end
