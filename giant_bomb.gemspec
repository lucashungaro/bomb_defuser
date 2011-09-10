# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "giant_bomb/version"

Gem::Specification.new do |s|
  s.name        = "giant_bomb"
  s.version     = GiantBomb::VERSION
  s.authors     = ["Lucas Húngaro"]
  s.email       = ["lucashungaro@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple wrapper for the awesome GiantBomb.com API}
  s.description = %q{A simple wrapper for the awesome GiantBomb.com API}

  s.rubyforge_project = "giant_bomb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"

  s.add_runtime_dependency "curb"
  s.add_runtime_dependency "hashie"
  s.add_runtime_dependency "yajl-ruby"
end
