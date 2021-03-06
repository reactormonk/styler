#!/usr/bin/env gem build
# encoding: utf-8
 
Gem::Specification.new do |s|
  s.name = "styler"
  s.version = "0.2.0"
  s.authors = ["Simon Hafner aka Tass"]
  s.homepage = "http://github.com/Tass/styler"
  s.summary = "This implements view-aware models, yet not."
  s.description = "This gem implements the presenter pattern with a mixin to use with rango."
  s.cert_chain = nil
  s.email = ["hafnersimon", "gmail.com"].join("@")
  s.has_rdoc = true
 
  # files
  s.files = Dir.glob("{lib,test}/**/*") + %w[LICENSE README.rdoc]
  s.require_paths = ["lib"]
 
  # Ruby version
  # Current JRuby with --1.9 switch has RUBY_VERSION set to "1.9.2dev"
  # and RubyGems don't play well with it, so we have to set minimal
  # Ruby version to 1.9, even if it actually is 1.9.1
  s.required_ruby_version = ::Gem::Requirement.new("~> 1.9")
 
  # === Dependencies ===
  # RubyGems has runtime dependencies (add_dependency) and
  # development dependencies (add_development_dependency)
 
end
