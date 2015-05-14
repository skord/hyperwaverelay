# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyperwaverelay/version'

Gem::Specification.new do |spec|
  spec.name          = "hyperwaverelay"
  spec.version       = Hyperwaverelay::VERSION
  spec.authors       = ["Mike Danko"]
  spec.email         = ["mike@l4m3.com"]

  spec.summary       = %q{Ansible Project Scaffolding}
  spec.description   = %q{Create and manage scaffolding for Ansible projects}
  spec.homepage      = "https://github.com/skord/hyperwaverelay"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "hwr"
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "sshkey", "~> 1.6.1"
end
