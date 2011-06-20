# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sermepa-rails/version"

Gem::Specification.new do |s|
  s.name        = "sermepa-rails"
  s.version     = SermepaRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roger Campos"]
  s.email       = ["roger@itnig.net"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "sermepa-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.0.0"
end
