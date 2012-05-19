require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "evolver/version"

task :gem => :build
task :build do
  system "gem build evolver.gemspec"
end

task :install => :build do
  system "sudo gem install evolver-#{Evolver::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Evolver::VERSION} -m 'Tagging #{Evolver::VERSION}'"
  system "git push --tags"
  system "gem push evolver-#{Evolver::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
