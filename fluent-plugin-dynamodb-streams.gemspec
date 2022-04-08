# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-dynamodb-streams-alt"
  spec.version       = "0.0.3"
  spec.authors       = ["krishna ramanathan"]
  spec.email         = ["krishna@amnic.com"]
  spec.summary       = %q{Amazon DynamoDB Streams input plugin for Fluentd}
  spec.description   = %q{Forked from takus/fluent-plugin-dynamodb-streams; with fixes from cosmo0920/fluent-plugin-dynamodb-streams}
  spec.homepage      = "https://github.com/amnickrishna/fluent-plugin-dynamodb-streams-alt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd", [">= 0.10.58", "< 2"]
  spec.add_dependency "aws-sdk", '~> 2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", ">= 3.1.0"
  spec.add_development_dependency "dynamodb-local"
end
