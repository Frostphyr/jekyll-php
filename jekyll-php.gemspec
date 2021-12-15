lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'jekyll-php/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-php'
  spec.version       = Php::VERSION
  spec.authors       = ['Frostphyr']
  spec.email         = ['contact@frostphyr.com']
  spec.license       = 'Apache-2.0'
  spec.summary       = 'Adds better support for PHP in Jekyll'
  spec.homepage      = 'https://github.com/Frostphyr/jekyll-php'

  spec.files = Dir['lib/**/*'] + %w(Rakefile Gemfile README.md CHANGELOG.md LICENSE.txt)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'jekyll', ['>= 3.2.0', '< 5']

  spec.add_development_dependency 'rake', '~> 13'
end
