# frozen_string_literal: true

require_relative "lib/rubocop/hk/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop-hk"
  spec.version       = Rubocop::Hk::VERSION
  spec.authors       = ["Hammad Khan"]
  spec.email         = ["hammadkhanxcm@gmail.com"]

  spec.summary       = "RuboCop HK"
  spec.description   = "Modern RuboCop configuration for Ruby and Rails applications"
  spec.homepage      = "https://github.com/hammadxcm/rubocop-hk"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hammadxcm/rubocop-hk"
  spec.metadata["changelog_uri"] = "https://github.com/hammadxcm/rubocop-hk/blob/main/CHANGELOG.md"
  # Enable MFA for security (2025 best practice)
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["README.md", "STYLEGUIDE.md", "LICENSE", "config/*.yml", "lib/**/*.rb"]
  spec.require_paths = ["lib"]

  # Gem dependencies
  spec.add_dependency("rubocop", "~> 1.80.0")
  spec.add_dependency("rubocop-performance", "~> 1.25.0")
  spec.add_dependency("rubocop-rails", "~> 2.33.0")
  spec.add_dependency("rubocop-rspec", "~> 3.6.0")
  spec.add_dependency("thor", "~> 1.0")

  # Development dependencies are defined in Gemfile

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
