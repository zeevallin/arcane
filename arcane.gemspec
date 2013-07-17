# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arcane/version'

Gem::Specification.new do |gem|

  gem.name          = "arcane"
  gem.version       = Arcane::VERSION
  gem.authors       = ["Philip Vieira", "Cloudsdale"]
  gem.email         = ["philip@vallin.se", "ask@cloudsdale.org"]

  gem.description   = "Parameter filter done OO, extending strong parameters."
  gem.summary       = "Extension for strong_parameters."
  gem.homepage      = "https://github.com/cloudsdaleapp/arcane"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency             "activesupport",     ">= 3.0.0"
  gem.add_dependency             "strong_parameters", ">= 0.2.0"

  gem.add_development_dependency "activerecord", ">= 3.0.0"
  gem.add_development_dependency "rspec",        "~>2.0"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"

end
