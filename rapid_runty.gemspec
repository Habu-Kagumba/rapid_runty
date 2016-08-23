# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapid_runty/version'

Gem::Specification.new do |spec|
  spec.name          = 'rapid_runty'
  spec.version       = RapidRunty::VERSION
  spec.authors       = ['Herbert Kagumba']
  spec.email         = ['herbert.kagumba@andela.com']

  spec.summary       = 'A minimal web framework'
  spec.description   = 'A minimal web framework to get your web project up '\
    'and running in seconds.'
  spec.homepage      = 'https://github.com/Habu-Kagumb/rapid_runty'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.10'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rack-test', '~> 0.6'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'capybara', '~> 2.7'
  spec.add_development_dependency 'coveralls', '~> 0.8'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'

  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'rubocop', '~> 0.42'
  spec.add_development_dependency 'brakeman', '~> 3.3'
  spec.add_development_dependency 'rubycritic', '~> 2.9'

  spec.add_dependency 'rack', '~> 2.0'
  spec.add_dependency 'bundler', '~> 1.12'
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'tilt', '~> 2.0'
  spec.add_dependency 'sqlite3', '~> 1.3'
end
