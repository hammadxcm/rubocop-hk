# RuboCop HK

> **Modern RuboCop configuration for Ruby and Rails applications**

[![Gem Version](https://badge.fury.io/rb/rubocop-hk.svg)](https://badge.fury.io/rb/rubocop-hk)
[![Ruby](https://img.shields.io/badge/ruby-3.1+-red.svg)](https://www.ruby-lang.org)
[![Rails](https://img.shields.io/badge/rails-7.0+-red.svg)](https://rubyonrails.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This gem provides a comprehensive RuboCop configuration optimized for modern Ruby and Rails applications, featuring performance optimizations, Rails 7.0+ compatibility, and modern conventions.

## Features

✨ **Modern Standards**
- Rails 7.0-8.0+ compatible
- Ruby 3.1+ optimized
- Double quote convention (Rails 7+ standard)
- Frozen string literals for performance
- 30+ performance optimization rules

✨ **Comprehensive Configuration**
- Modular architecture with 7 specialized configs
- Rails-specific rules and best practices
- RSpec testing integration
- Performance and thread-safety rules
- Thoughtful cop disabling for practical development

## Installation

Add to your application's Gemfile:

```ruby
group :development, :test do
  gem "rubocop-hk", require: false
end
```

Then execute:

```bash
$ bundle install
```

## Usage

Create a `.rubocop.yml` file in your project root:

```yaml
inherit_gem:
  rubocop-hk: config/default.yml
```

Run RuboCop:

```bash
# Check your code
$ bundle exec rubocop

# Auto-fix issues  
$ bundle exec rubocop --autocorrect
```

### Rails Integration (Rails 7.2+)

For automatic formatting after Rails generators:

```ruby
# config/application.rb or config/environments/development.rb
config.generators.apply_rubocop_autocorrect_after_generate!
```

## Configuration

### Custom Overrides

```yaml
# .rubocop.yml
inherit_gem:
  rubocop-hk: config/default.yml

# Override specific cops
Style/Documentation:
  Enabled: false

Metrics/ClassLength:
  Max: 150
```

### Available Configurations

The gem includes several modular configurations:

- `config/default.yml` - Main configuration with plugin setup
- `config/rubocop-rails.yml` - Rails-specific rules
- `config/rubocop-rspec.yml` - RSpec testing rules  
- `config/rubocop-performance.yml` - Performance optimization rules
- `config/rubocop-style.yml` - Style preferences and modern conventions
- `config/rubocop-layout.yml` - Code layout and formatting
- `config/rubocop-metrics.yml` - Complexity and size metrics
- `config/rubocop-lint.yml` - Error prevention and code quality

## Compatibility

### Supported Versions

| Ruby Version | Rails Versions | Status |
|--------------|---------------|--------|
| **Ruby 3.3+** | Rails 7.1-8.0+ | ✅ **Recommended** |
| **Ruby 3.2** | Rails 7.0-8.0+ | ✅ **Supported** |
| **Ruby 3.1** | Rails 7.0-7.2 | ✅ **Minimum** |

## Modern Conventions

This configuration enforces modern Ruby and Rails conventions:

### String Literals
```ruby
# Preferred (Double quotes)
message = "Hello, world!"
interpolation = "User: #{user.name}"

# Avoid (Single quotes) 
message = 'Hello, world!'
```

### Method Definitions
```ruby
# Preferred (with parentheses)
def calculate_total(items)
  items.sum(&:price)
end

def user_count()
  User.count
end
```

### Trailing Commas
```ruby
# Preferred (consistent trailing commas)
user_attributes = {
  name: "John",
  email: "john@example.com",
  role: "admin", # <- trailing comma
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests.

To test the configuration:

```bash
# Test on your own code
$ bundle exec rubocop

# Test specific files
$ bundle exec rubocop lib/ spec/
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hammadxcm/rubocop-hk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.md).

## Code of Conduct

Everyone interacting in the RuboCop HK project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Acknowledgments

- [RuboCop](https://github.com/rubocop/rubocop) - The Ruby static code analyzer
- [Ruby on Rails](https://rubyonrails.org/) - The web framework  
- Ruby Community - For coding standards and conventions