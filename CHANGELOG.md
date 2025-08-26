<div align="center">

# 📝 Changelog - RuboCop HK

> **All notable changes to this project are documented here**

[![Gem Version](https://badge.fury.io/rb/rubocop-hk.svg)](https://badge.fury.io/rb/rubocop-hk)
[![Keep a Changelog](https://img.shields.io/badge/changelog-Keep%20a%20Changelog-blue.svg)](https://keepachangelog.com)
[![Semantic Versioning](https://img.shields.io/badge/versioning-SemVer-green.svg)](https://semver.org)

</div>

---

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 📋 Version History

## [Unreleased]

## [1.1.1] - 2025-08-26

### 🔧 **Security Patch Release**

**Bug fix**: This patch release fixes security audit false positives in CI/CD workflows.

#### 🛡️ **Fixed**
- **Security scanning false positives**: Improved secret detection to exclude vendor dependencies
- **CI/CD reliability**: Security workflows no longer fail on legitimate code examples in gem dependencies
- **Testing scope**: Secret scanning now focuses only on source code directories (`lib/`, `config/`)
- **Performance**: Faster security scans by excluding irrelevant directories

#### 🔍 **Security Improvements**
- **Better filtering**: Exclude `vendor/bundle`, `.bundle`, test files from secret scanning  
- **Source code focus**: Only scan actual project code, not dependencies
- **Pattern refinement**: Improved regex to avoid common false positive patterns
- **Documentation**: Enhanced security testing documentation

#### 📊 **Technical Details**
- **Files changed**: `.github/workflows/security.yml`, `scripts/test-workflows.sh`
- **Scope**: No functional changes to RuboCop configuration
- **Compatibility**: Fully backward compatible with v1.1.0

## [1.1.0] - 2025-08-26

### 🚀 **2025 Modernization Release**

**Major modernization**: This release brings RuboCop HK up to 2025 standards with updated Ruby/Rails support, enhanced security, and comprehensive developer experience improvements.

#### 🔥 **Added**
- **Ruby 3.4 support**: Added parser engine configuration for Ruby 3.4+ compatibility
- **Rails 8.1 support**: Updated TargetRailsVersion for latest Rails features
- **Security workflows**: Comprehensive vulnerability scanning with bundler-audit and CodeQL
- **Local testing**: Pre-push workflow testing scripts (`scripts/pre-push-test.sh`)
- **EditorConfig**: Consistent editor behavior across development environments
- **Dependabot**: Automated dependency update management
- **Workflow testing documentation**: Complete guide in `WORKFLOW_TESTING.md`

#### ⬆️ **Updated**
- **Ruby requirement**: From `>= 3.1.0` to `>= 3.2.0` (Ruby 3.1 EOL March 2025)
- **RuboCop**: From `~> 1.79.2` to `~> 1.80.0` (latest stable)
- **rubocop-rails**: From `~> 2.32.0` to `~> 2.33.0` (latest features)
- **CI matrix**: Now tests Ruby 3.2, 3.3, 3.4 with Rails 7.0-8.0
- **Contributing guide**: Enhanced with conventional commits and examples
- **Makefile**: Added modern development targets (`test-workflows`, `security`, etc.)

#### 🛡️ **Security**
- **MFA requirement**: Enabled `rubygems_mfa_required` for secure gem publishing
- **Dependency conflicts**: Resolved Gemfile vs gemspec development dependency issues
- **Vulnerability scanning**: Daily automated security audits
- **Secret detection**: Basic hardcoded secret scanning in CI

#### 🔧 **Fixed**
- **Dependency management**: Moved development dependencies to Gemfile only (2025 best practice)
- **Parser configuration**: Added explicit parser engine for Ruby 3.4+ compatibility
- **Test expectations**: Updated all version references from 1.0.9 to 1.1.0
- **Configuration loading**: Enhanced RuboCop configuration validation

#### ⚠️ **Breaking Changes**
- **Ruby 3.1 support dropped**: Minimum Ruby version is now 3.2.0
- **Development dependencies**: No longer defined in gemspec (use Gemfile)
- **MFA required**: New gem versions require MFA for publishing

#### 📊 **Statistics**
- **Test Coverage**: 100% maintained (118 examples, 0 failures)
- **Security**: Zero vulnerabilities in dependencies
- **Code Quality**: Zero RuboCop violations
- **CI Matrix**: 12 Ruby/Rails combinations tested

## [1.0.0] - 2025-08-24

### 🎉 **Stable Release: Production-Ready RuboCop Configuration**

**Major milestone**: This marks the first stable release of RuboCop HK, a comprehensive Ruby and Rails linting solution trusted for production environments.

### ✨ **What's New in 1.0.0**
- **🏆 Production Stability**: 100% test coverage with 117 comprehensive tests
- **🚀 Rails 8 Ready**: Full compatibility with Rails 6.0-8.0+ including Omakase integration
- **📈 Enhanced Performance**: Comprehensive performance cops with auto-correction capabilities
- **🎯 Team-First Design**: Real-world configurations for startups, enterprises, and open source projects
- **📚 Complete Documentation**: Professional guides for every use case and setup scenario

### 🔧 **Major Features**
- **Multi-Version Support**: Ruby 3.0+ and Rails 6.0-8.0+ compatibility
- **Advanced Configuration**: 8 modular config files for granular control
- **Performance Optimization**: 18 performance cops with safe auto-correction
- **CI/CD Ready**: GitHub Actions, GitLab CI, Docker, and Jenkins integration
- **Migration Tools**: Complete guides for upgrading from other RuboCop configurations

### 📊 **Quality Metrics**
- ✅ **100% Test Coverage** (20/20 lines covered)
- ✅ **117 Comprehensive Tests** across all scenarios
- ✅ **Zero Test Failures** in production validation
- ✅ **Multi-Ruby Testing** (Ruby 3.1, 3.2, 3.3+)
- ✅ **Rails Compatibility** validated across 6.0-8.0

### 🎯 **Use Cases**
- **Startup Teams** (2-5 developers): Flexible configurations with learning-friendly rules
- **Enterprise Teams** (10+ developers): Strict standards with comprehensive documentation
- **Open Source Projects**: Community-standard configurations with contributor guidelines
- **Rails API Applications**: Optimized for API-only Rails applications
- **Microservices**: Configuration templates for distributed Ruby services

### ⚡ **Performance Highlights**
- **Fast Analysis**: Optimized for large codebases with parallel processing
- **Memory Efficient**: Intelligent caching and resource management
- **Auto-Correction**: 65%+ auto-correction rate with safe transformations
- **CI Optimization**: Intelligent failing fast with progress reporting

### 🔗 **Integration Support**
- **Editors**: VS Code, Vim/Neovim, RubyMine, Sublime Text
- **CI/CD**: GitHub Actions, GitLab CI, Circle CI, Jenkins
- **Containers**: Docker, Kubernetes, cloud deployment ready
- **Version Control**: Git hooks, pre-commit, and pull request automation

## [0.1.0] - 2025-08-24 (Deprecated)

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
  gem "rubocop-hk", "~> 1.0.9", require: false
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