spec = Gem::Specification.new do |s|
  s.name         = 'htty'
  s.version      = File.read('VERSION').chomp
  s.summary      = 'The HTTP TTY'
  s.description  = 'htty is a console application for interacting with HTTP '  +
                   'servers. It is something of a cross between curl and the ' +
                   'Lynx browser.'
  s.files        = %w(README.rdoc MIT-LICENSE.rdoc VERSION) +
                   Dir['app/**/*.rb']                       +
                   Dir['spec/**/*']
  s.has_rdoc     = true

  s.executables << 'htty'
  s.requirements << 'Ruby v1.9.2 or later'
  s.extra_rdoc_files = %w(README.rdoc MIT-LICENSE.rdoc)
  s.rdoc_options << '--title'  << 'htty, the HTTP TTY' <<
                    '--main'   << 'README.rdoc'        <<
                    '--output' << 'doc'

  s.author   = 'Nils Jonsson'
  s.email    = 'htty@nilsjonsson.com'
  s.homepage = 'http://htty.github.com'
end
