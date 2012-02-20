# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "whysoslow/version"

Gem::Specification.new do |s|
  s.name        = "whysoslow"
  s.version     = Whysoslow::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kelly Redding"]
  s.email       = ["kelly@kellyredding.com"]
  s.homepage    = "http://github.com/kellyredding/whysoslow"
  s.summary     = %q{A little runner/printer to benchmark Ruby code blocks}
  s.description = %q{A little runner/printer to benchmark Ruby code blocks}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler")
  s.add_development_dependency("assert")
end
