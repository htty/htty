require 'spec/rake/spectask'
require 'rake/rdoctask'

tasks_in_spec_namespace = []

task :default => :spec

desc 'Build the RDOC HTML Files'
task :doc => 'doc:rebuild'

namespace :doc do
  Rake::RDocTask.new :build do |rdoc|
    rdoc.title         = 'htty, the HTTP TTY'
    rdoc.main          = 'about.rdoc'
    rdoc.inline_source = false # Because RDoc no longer accepts this option.
    rdoc.rdoc_dir      = 'doc'
    rdoc.rdoc_files.include(*%w(about.rdoc
                                README.rdoc
                                MIT-LICENSE.rdoc
                                lib/**/*.rb))
  end
end

namespace :spec do |n|
  def define_spec_task(name)
    Spec::Rake::SpecTask.new name do |t|
      t.spec_opts  = %w(--backtrace --colour)
      t.spec_files = FileList["spec/#{name}/**/*_spec.rb"]
    end
  end

  desc 'Run unit specs'
  define_spec_task :unit

  desc 'Run system specs'
  define_spec_task :system

  tasks_in_spec_namespace = n.tasks
end

desc 'Run all specs'
task :spec => tasks_in_spec_namespace
