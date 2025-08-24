# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2025-08-24

### 🚀 Major Release: Complete Migration from rubocop-sendoso to rubocop-hk

This is a major version release representing a complete migration and rebranding from the original `rubocop-sendoso` gem to the new open-source `rubocop-hk` gem.

### ✅ Added
- **Performance Optimization**: Added `rubocop-performance` dependency (~> 1.25.0) with 30+ performance cops
- **Modern Plugin Architecture**: Updated to RuboCop 1.72+ plugin system using `plugins:` instead of `require:`
- **Enhanced Exclusions**: Comprehensive Rails project file exclusions (tmp/, log/, public/, storage/, etc.)
- **Frozen String Literals**: Enabled `Style/FrozenStringLiteralComment` for Ruby 3.1+ performance benefits
- **Version Targeting**: Explicit Ruby 3.1+ and Rails 7.0+ targeting for modern applications
- **GitHub Actions**: Complete CI/CD pipeline with multi-Ruby testing (3.1, 3.2, 3.3)
- **Architecture Documentation**: Comprehensive `ARCHITECTURE.md` with Mermaid diagrams
- **Development Documentation**: Enhanced `README.md` with usage examples and compatibility matrix

### 🔄 Changed  
- **Gem Name**: `rubocop-sendoso` → `rubocop-hk`
- **Module Structure**: `Rubocop::Sendoso` → `Rubocop::Hk` 
- **Directory Structure**: `lib/rubocop/sendoso/` → `lib/rubocop/hk/`
- **Author**: Updated to Hammad Khan
- **Repository**: Migrated to `https://github.com/hammadxcm/rubocop-hk`
- **License**: Updated copyright to Hammad Khan (2025)
- **Ruby Requirement**: `>= 3.1.6` → `>= 3.1.0` (broader compatibility)

### ⬆️ Updated Dependencies
- **RuboCop Core**: `~> 1.75.2` → `~> 1.79.2` (latest 2025 version)
- **rubocop-rails**: `~> 2.31.0` → `~> 2.32.0` (latest)
- **rubocop-rspec**: `~> 3.5.0` → `~> 3.6.0` (latest)

### 🗑️ Removed
- **Private Registry**: Removed GitHub Packages publishing configuration
- **CircleCI**: Replaced with GitHub Actions
- **Company References**: Removed all Sendoso-specific branding and references

### 💥 Breaking Changes
- **Module Names**: All references to `Rubocop::Sendoso` must be updated to `Rubocop::Hk`
- **Gem Name**: Projects using `gem "rubocop-sendoso"` must update to `gem "rubocop-hk"`
- **Configuration Inheritance**: Update `.rubocop.yml` to use `rubocop-hk: config/default.yml`
- **New Dependencies**: `rubocop-performance` is now included and may introduce new violations
- **Version Targeting**: Configuration optimized for Ruby 3.1+ and Rails 7.0+

### 🔧 Configuration Updates
- **Modern Conventions**: Double quotes enforced (Rails 7+ standard)
- **Trailing Commas**: Consistent comma style for better diffs
- **Performance Rules**: 30+ new performance optimization cops
- **Enhanced Formatting**: Added `DisplayStyleGuide: true` for better developer experience

### 🏗️ Infrastructure
- **GitHub Actions**: Automated testing on Ruby 3.1, 3.2, 3.3
- **Release Automation**: Automated gem building and GitHub releases
- **Public Distribution**: Ready for RubyGems.org publishing

### 📚 Documentation
- **README**: Complete rewrite with installation, usage, and compatibility guides
- **ARCHITECTURE**: Technical documentation with system diagrams  
- **CONTRIBUTING**: Open source contribution guidelines
- **CODE_OF_CONDUCT**: Updated contact information

### 🧪 Testing
- **RSpec Tests**: Updated for new module structure
- **Integration Tests**: Validated with latest RuboCop versions
- **Build Verification**: Confirmed gem builds and loads correctly

### 🔄 Migration Guide
For users migrating from `rubocop-sendoso`:

1. **Update Gemfile**:
   ```ruby
   # Before
   gem "rubocop-sendoso", github: "sendoso/rubocop-sendoso"
   
   # After  
   gem "rubocop-hk"
   ```

2. **Update .rubocop.yml**:
   ```yaml
   # Before
   inherit_gem:
     rubocop-sendoso: config/default.yml
   
   # After
   inherit_gem:
     rubocop-hk: config/default.yml
   ```

3. **Run bundle update** and address any new violations from performance cops

---

## [1.0.1] - 2025-04-08
### Fixed
- Updated RuboCop configuration to use `plugins` instead of `require` for rubocop-rspec and rubocop-rails extensions

## [1.0.0] - 2025-04-07
### Breaking Changes
- Updated required Ruby version to 3.1.7
- Updated RuboCop dependency to ~> 1.75.2
- Updated rubocop-rails dependency to ~> 2.31.0
- Updated rubocop-rspec dependency to ~> 3.5.0

### Security
- Updated rubocop-rails dependency to ~> 2.27 to address Rack security vulnerabilities (CVE-2025-27610, CVE-2025-25184, CVE-2025-27111)

## [0.1.0] - 2021-06-04
- Initial release