require 'guard/rspec/dsl'

debug_option = begin
                 require 'pry-byebug'
                 ' --require pry-byebug'
               rescue LoadError
                 nil
               end
guard :rspec, :all_on_start => true,
              :all_after_pass => true,
              :cmd => "bundle exec rspec --format progress#{debug_option}" do
  dsl = Guard::RSpec::Dsl.new(self)
  rspec, ruby = dsl.rspec, dsl.ruby

  # RSpec files
  watch('.rspec')          { rspec.spec_dir }
  watch rspec.spec_helper  { rspec.spec_dir }
  watch rspec.spec_support { rspec.spec_dir }
  watch rspec.spec_files

  # Run all specs when a shared spec changes.
  watch(%r{^spec/.+_sharedspec\.rb$}) { rspec.spec_dir }

  # Run all specs when the bundle changes.
  watch('Gemfile.lock') { rspec.spec_dir }

  # Ruby files
  dsl.watch_spec_files_for ruby.lib_files

  # Run the corresponding spec(s) (or all specs) when code changes.
  watch(%r{^lib/(.+)\.rb$}) do |match|
    corresponding_specs = Dir["spec/{integration,unit}/#{match[1]}_spec.rb"]
    corresponding_specs.empty? ? rspec.spec_dir : corresponding_specs
  end
end
