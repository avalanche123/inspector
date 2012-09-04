require File.expand_path("../lib/frank/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "frank"
  gem.version       = Frank::VERSION
  gem.license       = 'MIT'
  gem.authors       = ["Bulat Shakirzyanov"]
  gem.email         = ["mallluhuct@gmail.com"]
  gem.homepage      = "http://avalanche123.github.com/frank"
  gem.summary       = "frank - ruby validation library"
  gem.description   = "Frank is a validation library for Ruby with zero assumptions"

  gem.required_ruby_version = '>= 1.9.2'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'cucumber', '~> 1.2'
  gem.add_development_dependency 'aruba', '~> 0.4'
  gem.add_development_dependency 'rake', '~> 0.9'
end