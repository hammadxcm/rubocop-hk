# frozen_string_literal: true

require_relative "lib/rubocop/sendoso/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop-sendoso"
  spec.version       = Rubocop::Sendoso::VERSION
  spec.authors       = ["Sendoso"]
  spec.email         = ["engineering@sendoso.com"]

  spec.summary       = "RuboCop Sendoso"
  spec.description   = "Code style checking for Sendoso Ruby repositories"
  spec.homepage      = "https://github.com/sendoso/rubocop-sendoso"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1.6"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/sendoso"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sendoso/rubocop-sendoso"
  spec.metadata["changelog_uri"] = "https://github.com/sendoso/rubocop-sendoso"

  spec.files = Dir["README.md", "STYLEGUIDE.md", "LICENSE", "config/*.yml", "lib/**/*.rb"]
  spec.require_paths = ["lib"]

  # Gem dependencies
  spec.add_dependency("rubocop", "~> 1.75.2")
  spec.add_dependency("rubocop-rails", "~> 2.31.0")
  spec.add_dependency("rubocop-rspec", "~> 3.5.0")

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
