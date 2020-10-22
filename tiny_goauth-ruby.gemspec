# frozen_string_literal: true

require_relative 'lib/tiny_goauth/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'tiny_goauth-rails'
  spec.version       = TinyGoauth::Rails::VERSION
  spec.authors       = ['maxshend']
  spec.email         = ['shendrik.mv@gmail.com']

  spec.summary       = 'Integration with tiny-goauth for Rails apps.'
  spec.description   = 'Integration with tiny-goauth for Rails apps.'
  spec.homepage      = 'https://github.com/maxshend/tiny_goauth-rails'
  spec.license       = 'MIT'

  spec.add_dependency 'active_interaction', '>= 3.8'
  spec.add_dependency 'railties', '>= 6'

  spec.files = %w[README.md LICENSE.txt]
  spec.files         += %w[tiny_goauth-rails.gemspec]
  spec.files         += Dir['{app,lib,config}/**/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
end
