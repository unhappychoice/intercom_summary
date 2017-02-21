# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intercom_summary/version'

Gem::Specification.new do |spec|
  spec.name          = "intercom_summary"
  spec.version       = IntercomSummary::VERSION
  spec.authors       = ["unhappychoice"]
  spec.email         = ["unhappychoice@gmail.com"]

  spec.summary       = %q{This gem only shows summary information on intercom.}
  spec.description   = %q{This gem only shows summary information on intercom.}
  spec.homepage      = 'https://github.com/unhappychoice/intercom_summary'
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'intercom', '~> 3.5.10'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
