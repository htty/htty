yard, rspec = false, false

begin
  require 'yard'
rescue LoadError
  desc '(Not available -- install YARD)'
  task :doc do
    STDERR.puts '*** Install YARD in order to build documentation'
  end
else
  yard = true
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

begin
  require 'rspec/core/rake_task'
rescue LoadError
  desc '(Not available -- install RSpec)'
  task :spec do
    STDERR.puts '*** Install RSpec in order to run specs'
  end
else
  rspec = true

  def define_spec_task(name, as_subdirectory=true)
    RSpec::Core::RakeTask.new name do |t|
      t.rspec_opts = ['--color']
      # TODO: Change '-d' to '--debug' when that `rspec` bug is fixed
      t.rspec_opts << '-d'

      directory = as_subdirectory ? "spec/#{name}" : 'spec'
      t.pattern = "#{directory}/**/*_spec.rb"
    end
  end

  namespace :spec do |n|
    %w(unit integration system).each do |type_of_spec|
      desc "Run #{type_of_spec} specs"
      define_spec_task type_of_spec
    end
  end

  desc 'Run all specs'
  define_spec_task :spec, false
end

if yard && !rspec
  desc 'Generate YARD documentation'
  task '' => :doc
  task :default => :doc
else
  desc 'Run all specs'
  task '' => :spec
  task :default => :spec
end
