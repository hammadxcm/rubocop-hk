# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-08-24

### 🚀 Initial Release: RuboCop HK

Modern RuboCop configuration gem optimized for Ruby and Rails applications with performance enhancements and contemporary coding standards.

### ✅ Features
- **Performance Optimization**: Includes `rubocop-performance` (~> 1.25.0) with 30+ performance cops
- **Modern Plugin Architecture**: Uses RuboCop 1.72+ plugin system with `plugins:` configuration
- **Rails Compatibility**: Full support for Rails 7.0-8.0+ applications
- **Ruby 3.1+ Optimized**: Targets modern Ruby versions with performance benefits
- **Comprehensive Exclusions**: Smart exclusions for Rails project structure (tmp/, log/, public/, storage/)
- **Frozen String Literals**: Enabled for Ruby 3.1+ performance improvements
- **Modern Conventions**: Double quotes (Rails 7+ standard), consistent trailing commas

### 📦 Dependencies
- **RuboCop Core**: ~> 1.79.2 (latest 2025 version)
- **rubocop-rails**: ~> 2.32.0 (Rails best practices)
- **rubocop-rspec**: ~> 3.6.0 (RSpec testing standards)
- **rubocop-performance**: ~> 1.25.0 (Performance optimizations)

### ⚙️ Configuration Modules
- `config/default.yml` - Main configuration with plugin setup
- `config/rubocop-rails.yml` - Rails-specific rules and best practices
- `config/rubocop-rspec.yml` - RSpec testing conventions
- `config/rubocop-performance.yml` - Performance optimization rules (30+ cops)
- `config/rubocop-style.yml` - Modern style preferences
- `config/rubocop-layout.yml` - Code layout and formatting
- `config/rubocop-metrics.yml` - Complexity and size metrics
- `config/rubocop-lint.yml` - Error prevention and code quality

### 🎯 Modern Standards
- **String Literals**: Double quotes enforced (Rails 7+ convention)
- **Frozen String Literals**: Enabled for Ruby 3.1+ performance
- **Trailing Commas**: Consistent comma style for better git diffs
- **Method Definitions**: Parentheses required for clarity
- **Hash Syntax**: Modern Ruby 1.9+ syntax (`key: value`)

### 🏗️ Infrastructure
- **GitHub Actions**: Automated CI/CD with multi-Ruby testing (3.1, 3.2, 3.3)
- **Release Automation**: Automated gem building and GitHub releases
- **Multi-Version Support**: Ruby 3.1+ and Rails 7.0+ compatibility
- **Open Source Ready**: MIT license with comprehensive documentation

### 📚 Documentation
- **README**: Installation, usage, and compatibility guides
- **ARCHITECTURE**: Technical documentation with system diagrams
- **CONTRIBUTING**: Open source contribution guidelines
- **CHANGELOG**: Semantic versioning and release notes

### 💡 Usage
Add to your Gemfile:
```ruby
group :development, :test do
  gem "rubocop-hk", require: false
end
```

Configure in `.rubocop.yml`:
```yaml
inherit_gem:
  rubocop-hk: config/default.yml
```

### 🔧 Compatibility
- **Ruby**: 3.1.0+ (minimum requirement)
- **Rails**: 7.0+ (optimized for modern Rails)
- **RuboCop**: 1.79+ (latest features and performance)