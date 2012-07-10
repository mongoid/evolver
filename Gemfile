source :rubygems
gemspec

group :test do
  gem "rspec", "~> 2.11"

  unless ENV["CI"]
    gem "guard", "1.2.1"
    gem "guard-rspec", "~> 0.7"
  end
end

gem "rake"
