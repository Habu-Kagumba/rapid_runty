# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapid_runty/version'

Gem::Specification.new do |spec|
  spec.name          = "rapid_runty"
  spec.version       = RapidRunty::VERSION
  spec.authors       = ["Herbert Kagumba"]
  spec.email         = ["herbert.kagumba@andela.com"]

  spec.summary       = %q{A minimal web framework}
  spec.description   = %q{A minimal web framework to get your web project up and running in seconds.}
  spec.homepage      = "https://github.com/andela-hkagumba/rapid_runty"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.12"

  spec.add_runtime_dependency "rack", "~> 2.0"
end
