# RuboCop HK

[![Gem Version](https://badge.fury.io/rb/rubocop-hk.svg)](https://badge.fury.io/rb/rubocop-hk)
[![Ruby](https://img.shields.io/badge/ruby-3.3+-red.svg)](https://www.ruby-lang.org)
[![Rails](https://img.shields.io/badge/rails-7.1+-red.svg)](https://rubyonrails.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive RuboCop configuration for modern Ruby 3.3+ and Rails 7.1+ applications, featuring 45+ warning-only modern rules with team-focused gradual adoption.

## Features

- **Modern Ruby & Rails Support**: Target Ruby 3.3+ and Rails 8.0+ with latest patterns
- **Warning-Only Modern Rules**: 45+ new rules as warnings to enable gradual adoption
- **Team-Focused**: Educational approach with clear explanations for each rule
- **Zero Breaking Changes**: All new features are opt-in warnings only
- **Comprehensive Coverage**: Style, Rails, RSpec, Performance, and Lint rules
- **Production Ready**: 100% test coverage with extensive CI/CD validation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-hk', '~> 1.3.0', require: false
```

And then execute:

```bash
bundle install
```

## Quick Start

1. Create a `.rubocop.yml` file in your project root:

```yaml
inherit_gem:
  rubocop-hk: config/default.yml
```

2. Run RuboCop:

```bash
bundle exec rubocop
```

3. Review warnings and gradually promote them to errors when your team is ready:

```bash
# View current warnings
bundle exec rubocop --format json | jq '.files[].offenses[] | select(.severity=="warning")'

# Use the promotion script (see documentation)
ruby scripts/promote-warnings.rb
```

## Configuration Options

RuboCop HK provides several preconfigured options:

- `config/default.yml` - Balanced configuration with modern warning-only rules
- `config/strict.yml` - More stringent rules for mature codebases
- `config/rails.yml` - Rails-specific optimizations

See [CUSTOMIZATION.md](CUSTOMIZATION.md) for detailed configuration options.

## Documentation

- **[Usage Guide](USAGE.md)** - Comprehensive usage instructions and examples
- **[Gradual Adoption Guide](GRADUAL_ADOPTION_GUIDE.md)** - Team-focused 4-phase adoption strategy
- **[Modern Rules Reference](MODERN_RULES_REFERENCE.md)** - Educational explanations for all 45+ new rules
- **[Customization Guide](CUSTOMIZATION.md)** - Advanced configuration and customization options
- **[Quick Start Guide](QUICK_START.md)** - Getting started and basic setup

## Requirements

- Ruby >= 3.3.0
- RuboCop >= 1.78.0
- Rails >= 7.1.0 (if using Rails cops)

## New in v1.3.0

This maintenance release focuses on cross-platform reliability and security:

- **✅ All CI/CD checks passing** - Ruby 3.3 & 3.4 on Ubuntu, macOS, and Windows
- **🔒 Security updates** - Updated rack, rexml, and uri to fix 7 CVEs
- **🔧 Fixed Windows compatibility** - Enhanced test suite for Windows platforms
- **⚡ Improved plugin loading** - Updated to modern `plugins:` directive
- **🎯 RuboCop 1.78-1.81 compatible** - Verified compatibility across versions
- **📦 45+ warning-only modern rules** - Gradual adoption without breaking builds

See [CHANGELOG.md](CHANGELOG.md) for complete release notes and security details.

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).