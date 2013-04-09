interactor :off

guard :rspec, :cli => '--debug' do
  # Run the corresponding spec(s) (or all specs) when code changes.
  watch(%r{^lib/(.+)\.rb$}) do |match|
    corresponding_specs = Dir["spec/{integration,unit}/#{match[1]}_spec.rb"]
    corresponding_specs.empty? ? 'spec' : corresponding_specs
  end

  # Run a spec when it changes.
  watch %r{^spec/.+_spec\.rb$}

  # Run all specs when the RSpec configuration changes.
  watch('.rspec'             ) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }

  # Run all specs when the bundle changes.
  watch('Gemfile.lock') { 'spec' }
end
