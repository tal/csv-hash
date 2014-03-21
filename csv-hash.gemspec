# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "csv-hash"
  spec.version       = CSVHash::VERSION
  spec.authors       = ["Tal Atlas"]
  spec.email         = ["me@tal.by"]
  spec.summary       = %q{A gem for interacting with the MTA APIs}
  spec.description   = %q{A gem for interacting with the MTA APIs}
  spec.homepage      = "https://github.com/tal/csv-hash"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2"
end
