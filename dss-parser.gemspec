# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dss_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "dss_parser"
  spec.version       = DssParser::VERSION
  spec.authors       = ["Graham Hadgraft"]
  spec.email         = ["graham@spicerack.co.uk"]
  spec.summary       = %q{A parser for DSS comments}
  spec.description   = %q{Parses DSS comments from css files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0.0"
end
