require 'bundler'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'ruby-debug'
require 'yard'

Bundler::GemHelper.install_tasks

namespace :build do
  YARD::Rake::YardocTask.new :doc
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
        print "\x1b[1;32m.\x1b[0m"
      end
      command = "/usr/bin/env ruby -e 'require File.expand_path(#{f.inspect})'"
      break unless system(command)
    end
    puts unless verbose?
  end
end

Cucumber::Rake::Task.new :features, 'Test features'

def define_spec_task(name, options={})
  RSpec::Core::RakeTask.new name do |t|
    t.rspec_opts = ['--color']
    t.skip_bundler = options[:skip_bundler]
    unless options[:debug] == false
      # TODO: Change '-d' to '--debug' when that `rspec` bug is fixed
      t.rspec_opts << '-d'
    end

    directory = options[:as_subdirectory] ? "spec/#{name}" : 'spec'
    t.pattern = "#{directory}/**/*_spec.rb"
  end
end

namespace :spec do |n|
  %w(unit integration system).each do |type_of_spec|
    desc "Run #{type_of_spec} specs"
    define_spec_task type_of_spec, :as_subdirectory => true
  end
end

desc 'Run all specs'
define_spec_task :spec

desc 'Run all specs and test features'
task ''       => [:spec, :features]
task :default => [:spec, :features]

# Support the 'gem test' command.
namespace :test do
  desc ''
  define_spec_task :specs, :debug => false, :skip_bundler => true

  Cucumber::Rake::Task.new :features, '' do |t|
    t.bundler = false
    t.cucumber_opts = '--backtrace'
  end
end
task :test => %w(test:specs test:features)
