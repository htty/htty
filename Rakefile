require 'spec/rake/spectask'
require 'yard'

tasks_in_spec_namespace = []

task :default => :spec

YARD::Rake::YardocTask.new :doc

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
