spec = Gem::Specification.new do |s|
  s.name         = 'htty'
  s.version      = File.read('VERSION').chomp
  s.summary      = 'The HTTP TTY'
  s.description  = 'htty is a console application for interacting with HTTP '  +
                   'servers. It is something of a cross between curl and the ' +
                   'Lynx browser.'
  s.files        = %w(README.markdown
                      History.markdown
                      MIT-LICENSE.markdown
                      VERSION) +
                   Dir['lib/**/*.rb']   +
                   Dir['spec/**/*']
  s.has_rdoc     = true

  s.executables << 'htty'

  s.add_dependency 'bluecloth', '>= 2.0.7'
  s.add_dependency 'yard',      '>= 0.6.1'

  s.add_development_dependency 'rake',  '>= 0.8.7'
  s.add_development_dependency 'rspec', '>= 1.3.0'

  s.requirements << 'Ruby v1.8.7 or later'

  s.author   = 'Nils Jonsson'
  s.email    = 'htty@nilsjonsson.com'
  s.homepage = 'http://htty.github.com'
end
