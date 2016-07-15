# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'between_the_sheets/version'

Gem::Specification.new do |spec|
  spec.name          = "between_the_sheets"
  spec.version       = BetweenTheSheets::VERSION
  spec.authors       = ["Chris Roerig"]
  spec.email         = ["idwyjm@gmail.com"]

  spec.summary       = %q{A simple card game I used to play at the bar.}
  spec.description   = %q{The player is shown 2 cards and then wagers if the next card will be between the first 2. }
  spec.homepage      = "https://github.com/chris-roerig/between_the_sheets"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "colorize", "~> 0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
