require_relative 'lib/tiny_goauth/ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'tiny_goauth-ruby'
  spec.version       = TinyGoauth::Ruby::VERSION
  spec.authors       = ['maxshend']
  spec.email         = ['shendrik.mv@gmail.com']

  spec.summary       = 'Integration with tiny-goauth for ruby apps.'
  spec.description   = 'Integration with tiny-goauth for ruby apps.'
  spec.homepage      = 'https://github.com/maxshend/tiny_goauth-ruby'
  spec.license       = 'MIT'

  spec.files         = %w[README.md LICENSE]
  spec.files         += %w[tiny_goauth-ruby.gemspec]
  spec.files         += Dir['lib/**/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
end
