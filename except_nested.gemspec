# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "date"
require "except_nested/version"

Gem::Specification.new do |spec|
  spec.name          = "except_nested"
  spec.version       = ExceptNested::VERSION
  spec.date          = Date.today.to_s
  spec.authors       = ["Abdullah Barrak"]
  spec.email         = ["abdullah@abarrak.com"]

  spec.summary       = "An extended version of active_support #except hash utility."
  spec.description   = "except_nested allows extraction of given hash values at various depth of the hash."
  spec.homepage      = "https://github.com/abarrak/except_nested"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 6', '< 8'
  spec.add_development_dependency "bundler", "~> 2.2.20"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1"
end
