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
      begin
        require 'ruby-debug'
      rescue LoadError
      else
        # TODO: Change '-d' to '--debug' when that `rspec` bug is fixed
        t.rspec_opts << '-d'
      end

      directory = as_subdirectory ? "spec/#{name}" : 'spec'
      t.pattern = "#{directory}/**/*_spec.rb"
    end
  end

  namespace :spec do |n|
    desc 'Run unit specs'
    define_spec_task :unit

    desc 'Run system specs'
    define_spec_task :system
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
