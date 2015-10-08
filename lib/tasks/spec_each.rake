begin
  require 'rspec/core/rake_task'
rescue LoadError
else
  namespace :spec do
    desc "Run each spec individually, looking for missing 'require' statements"
    task :each do
      add_separator = false
      Dir.glob( 'spec/**/*_spec.rb' ) do |f|
        puts '-' * `tput cols`.chomp.to_i if add_separator
        add_separator = true
        puts "Running #{f} ..."
        unless system( "/usr/bin/env bundle exec rspec --format=progress --no-profile #{f.inspect}" )
          fail
        end
      end
    end
  end
end
