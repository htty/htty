spec = Gem::Specification.new do |s|
  s.name         = 'htty'
  s.version      = File.read('VERSION').chomp
  s.summary      = 'The HTTP TTY'
  s.description  = 'htty is a console application for interacting with HTTP ' +
                   'servers. It is something of a cross between cURL and a '  +
                   'browser.'
  s.license      = 'MIT'
  s.files        = %w(README.markdown
                      History.markdown
                      MIT-LICENSE.markdown
                      VERSION) +
                   Dir['lib/**/*.rb']   +
                   Dir['spec/**/*']
  s.has_rdoc     = true

  s.executables << 'htty'

  s.add_development_dependency 'bluecloth', '~> 2.0'
  s.add_development_dependency 'rake',      '~> 0.8'
  s.add_development_dependency 'rspec',     '~> 2.0'
  s.add_development_dependency 'yard',      '~> 0.2'

  s.required_ruby_version = '>= 1.8.7'

  s.author   = 'Nils Jonsson'
  s.email    = 'htty@nilsjonsson.com'
  s.homepage = 'http://htty.github.com'

  s.rubyforge_project = 'htty'
end
