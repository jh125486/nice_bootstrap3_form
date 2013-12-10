# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nice_bootstrap3_form/version'

Gem::Specification.new do |spec|
  spec.name          = 'nice_bootstrap3_form'
  spec.version       = NiceBootstrap3Form::VERSION
  spec.authors       = ['Jacob']
  spec.email         = ['jacob.hochstetler@gmail.com']
  spec.description   = %q{Rails HTML/Form helpers for Twitter Bootstrap 3}
  spec.summary       = %q{Includes HTML helpers, Form helpers, and JS to integrate Rails with Twitter Boostrap 3}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 4.7'
  spec.add_development_dependency 'minitest-rails'
  spec.add_development_dependency 'rails'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'actionpack'
  spec.add_dependency 'railties'
  spec.add_dependency 'nested_form'
end
