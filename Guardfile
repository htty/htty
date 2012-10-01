guard :rspec, :cli => '--color' do
  # Run the corresponding spec (or all specs) when code changes.
  watch( %r{^lib/(.+)\.rb$} ) do |match|
    corresponding_specs = %W(spec/integration/#{match[1]}_spec.rb
                             spec/unit/#{match[1]}_spec.rb)
    existing = corresponding_specs.select do |s|
      File.file? File.expand_path( "../#{s}", __FILE__ )
    end
    existing.empty? ? 'spec' : existing
  end

  # Run a spec when it changes.
  watch %r{^spec/.+_spec\.rb$}

  # Run all specs when the bundle changes.
  watch( 'Gemfile.lock' ) { 'spec' }
end
