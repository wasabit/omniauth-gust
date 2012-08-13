# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-gust/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-gust"
  s.version     = Omniauth::Gust::VERSION
  s.authors     = ["Sebastian Rabuini"]
  s.email       = ["srabuini@gmail.com"]
  s.homepage    = "https://github.com/wasabit/omniauth-gust"
  s.summary     = %q{Gust OAuth strategy for OmniAuth}
  s.description = %q{Gust OAuth strategy for OmniAuth}

  s.rubyforge_project = "omniauth-gust"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'omniauth', '~> 1.0'
  s.add_dependency 'omniauth-oauth2', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end
