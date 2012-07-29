# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "evolver/version"

Gem::Specification.new do |s|
  s.name        = "evolver"
  s.version     = Evolver::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Durran Jordan"]
  s.email       = ["durran@gmail.com"]
  s.homepage    = "http://mongoid.org"
  s.summary     = "Database Schema Evolution for MongoDB"
  s.description = "Evolver Aids in Performing Database Migrations In MongoDB."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency("mongoid", ["~> 3.0"])
  s.add_dependency("railties", ["~> 3.2"])

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md Rakefile)
  s.require_path = "lib"
end
