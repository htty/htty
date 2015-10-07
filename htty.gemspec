# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'htty/version'

Gem::Specification.new do |spec|
  spec.name        = 'htty'
  spec.version     = HTTY::VERSION
  spec.authors     = ['Nils Jonsson']
  spec.email       = ['nils@alumni.rice.edu']

  spec.summary     = 'The HTTP TTY'
  spec.description = <<-end_description.gsub(/^\s+/, '').chomp
                       htty is a console application for interacting with web
                       servers. It's a fun way to explore web APIs and to learn
                       the ins and outs of HTTP.
                     end_description
  spec.homepage    = 'http://htty.github.io'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_dependency             'mime-types', '~>  1'
  spec.add_development_dependency 'bundler',    '~>  1'
  spec.add_development_dependency 'rake',       '~> 10'
  spec.add_development_dependency 'rspec',      '~>  3'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                         f.match(%r{^(test|spec|features)/})
                       end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename f }
  spec.require_paths = %w(lib)
end
