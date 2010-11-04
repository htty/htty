require 'rspec/core/rake_task'
require 'yard'

tasks_in_spec_namespace = []

task :default => :spec

YARD::Rake::YardocTask.new :doc

namespace :spec do |n|
  def define_spec_task(name)
    RSpec::Core::RakeTask.new name do |t|
      t.rspec_opts = %w(--backtrace --color)
      t.pattern    = "spec/#{name}/**/*_spec.rb"
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
