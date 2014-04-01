require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

begin
  require 'yard'
rescue LoadError
else
  namespace :build do
    YARD::Rake::YardocTask.new :doc
  end
end

namespace :lib do
  desc "Check the source for missing 'require' statements. Set the 'VERBOSE' " +
       'environment variable to "t[rue]" to display the name of each file as ' +
       'it is loaded.'
  task :find_missing_requires do
    def verbose?
      ENV['VERBOSE'].to_s =~ /^T/i
    end

    Dir.glob 'lib/**/*.rb' do |f|
      if verbose?
        puts "* #{f}"
      else
        print "\e[32m.\e[0m"
      end
      command = "/usr/bin/env ruby -e 'require File.expand_path(#{f.inspect})'"
      break unless system(command)
    end
    puts unless verbose?
  end
end

def define_spec_task(name, options={})
  RSpec::Core::RakeTask.new name do |t|
    t.rspec_opts ||= []
    unless options[:debug] == false
      begin
        require 'ruby-debug'
      rescue LoadError
      else
        t.rspec_opts << '--debug'
      end
    end

    directory = options[:as_subdirectory] ? "spec/#{name}" : 'spec'
    t.pattern = %W(#{directory}/*_spec.rb #{directory}/**/*_spec.rb)
  end
end

namespace :spec do |n|
  %w(unit integration).each do |type_of_spec|
    desc "Run #{type_of_spec} specs"
    define_spec_task type_of_spec, :as_subdirectory => true
  end
end

desc 'Run all specs'
define_spec_task :spec

desc 'Run all specs'
task ''       => :spec
task :default => :spec

# Support the 'gem test' command.
desc ''
define_spec_task :test, :debug => false
