require 'guard/rspec/dsl'

debugger_gem = %w(pry-byebug pry-debugger).detect do |gem|
  `bundle show #{gem} 2>&1 >/dev/null`
  $?.success?
end
debugger_require = debugger_gem ? " --require #{debugger_gem}" : nil

guard :rspec, all_on_start: true,
              all_after_pass: true,
              cmd: "bundle exec rspec --format progress#{debugger_require}" do
  dsl = Guard::RSpec::Dsl.new(self)
  rspec, ruby = dsl.rspec, dsl.ruby

  # RSpec files
  watch('.rspec')          { rspec.spec_dir }
  watch rspec.spec_helper  { rspec.spec_dir }
  watch rspec.spec_support { rspec.spec_dir }
  watch(%r{^spec/support}) { rspec.spec_dir } # This should not be necessary.
  watch rspec.spec_files

  # Run all specs when a shared spec changes.
  watch(%r{^spec/.+_sharedspec\.rb$}) { rspec.spec_dir }

  # Run all specs when the bundle changes.
  watch('Gemfile.lock')      { rspec.spec_dir }
  watch(%r{^(.+)\.gemspec$}) { rspec.spec_dir }

  # Ruby files
  dsl.watch_spec_files_for ruby.lib_files

  # Run the corresponding spec(s) (or all specs) when code changes.
  watch(%r{^lib/(.+)\.rb$}) do |match|
    corresponding_specs = Dir["spec/{integration,unit}/#{match[1]}_spec.rb"]
    corresponding_specs.empty? ? rspec.spec_dir : corresponding_specs
  end
end
