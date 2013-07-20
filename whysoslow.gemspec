# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "whysoslow/version"

Gem::Specification.new do |gem|
  gem.name        = "whysoslow"
  gem.version     = Whysoslow::VERSION
  gem.authors     = ["Kelly Redding"]
  gem.email       = ["kelly@kellyredding.com"]
  gem.description = %q{A little runner/printer to benchmark Ruby code blocks}
  gem.summary     = %q{A little runner/printer to benchmark Ruby code blocks}
  gem.homepage    = "http://github.com/kellyredding/whysoslow"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("assert", ["~> 2.0"])

  gem.add_dependency("ansi", ["~> 1.4"])

end
