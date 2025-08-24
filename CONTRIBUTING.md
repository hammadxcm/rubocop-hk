# Contributing to RuboCop HK

Thank you for your interest in contributing to RuboCop HK! This guide will help you get started with contributing to this open-source RuboCop configuration gem.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Contributions](#making-contributions)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Style Guidelines](#style-guidelines)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to hammadkhanxcm@gmail.com.

## Getting Started

### What is RuboCop HK?

RuboCop HK is a comprehensive RuboCop configuration gem optimized for modern Ruby and Rails applications. It provides:

- 📏 **Style rules** for consistent code formatting
- ⚡ **Performance rules** for optimized Ruby code  
- 🚀 **Rails rules** for Rails best practices
- 🧪 **RSpec rules** for testing standards
- 📊 **Metrics rules** for code complexity management

### Ways to Contribute

There are many ways to contribute to RuboCop HK:

- 🐛 **Report bugs** - Help us identify issues
- 💡 **Suggest enhancements** - Propose new features or improvements
- 📖 **Improve documentation** - Help make our docs clearer
- 🔧 **Fix issues** - Submit pull requests for bug fixes
- ✨ **Add new rules** - Propose new RuboCop cop configurations
- 🧪 **Improve tests** - Enhance our test coverage
- 💬 **Help others** - Answer questions in issues and discussions

## Development Setup

### Prerequisites

- **Ruby**: 3.1.0 or higher
- **Bundler**: Latest version
- **Git**: For version control

### Local Setup

1. **Fork the repository** on GitHub

2. **Clone your fork**:
   ```bash
   git clone git@github.com:YOUR-USERNAME/rubocop-hk.git
   cd rubocop-hk
   ```

3. **Install dependencies**:
   ```bash
   bundle install
   ```

4. **Verify setup**:
   ```bash
   # Run tests
   bundle exec rspec
   
   # Run RuboCop on itself
   bundle exec rubocop
   
   # Test gem loading
   bundle exec ruby -e "require 'rubocop/hk'; puts Rubocop::Hk::VERSION"
   ```

## Making Contributions

### Before You Start

1. **Check existing issues** - Look for similar bug reports or feature requests
2. **Create an issue** - Discuss your idea before implementing large changes
3. **Get feedback** - Ensure your contribution aligns with project goals

### Types of Contributions

#### 🐛 Bug Reports

When reporting bugs, please include:

- **Ruby version**: `ruby --version`
- **Rails version** (if applicable): `rails --version`  
- **RuboCop HK version**: Check your Gemfile.lock
- **Steps to reproduce**: Minimal example that demonstrates the issue
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Configuration**: Your `.rubocop.yml` if relevant

#### 💡 Feature Requests

For feature requests, provide:

- **Problem description**: What issue does this solve?
- **Proposed solution**: How should it work?
- **Alternatives considered**: Other approaches you've thought about
- **Examples**: Code examples if applicable

#### 📖 Documentation Improvements

Documentation contributions are always welcome:

- Fix typos and grammar
- Clarify confusing sections
- Add usage examples
- Improve formatting
- Update outdated information

## Testing

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/rubocop/hk_spec.rb

# Run with coverage
bundle exec rspec --format documentation
```

### Testing Your Changes

1. **Unit tests**: Ensure existing tests pass
2. **Manual testing**: Test your changes manually
3. **Integration testing**: Test with real Rails applications
4. **Multi-version testing**: Test across Ruby/Rails versions

### Adding Tests

When contributing code changes:

- Add tests for new functionality
- Update tests for changed functionality  
- Ensure test coverage remains high
- Use descriptive test names

Example test structure:
```ruby
RSpec.describe Rubocop::Hk do
  describe "new feature" do
    it "behaves correctly in normal case" do
      # Test implementation
    end
    
    it "handles edge cases" do
      # Edge case testing
    end
  end
end
```

## Submitting Changes

### Pull Request Process

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

2. **Make your changes**:
   - Follow our style guidelines
   - Add tests for new functionality
   - Update documentation if needed

3. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Brief description of changes
   
   Longer explanation of what changed and why.
   Include any breaking changes or migration notes."
   ```

4. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**:
   - Use a descriptive title
   - Reference related issues (#123)
   - Provide clear description of changes
   - Add examples if applicable

### Pull Request Guidelines

**Title Format**:
- `Fix: Brief description of bug fix`
- `Add: Brief description of new feature`
- `Update: Brief description of improvement`
- `Docs: Brief description of documentation change`

**Description Template**:
```markdown
## Summary
Brief description of what this PR does.

## Changes
- Change 1
- Change 2
- Change 3

## Testing
- [ ] All existing tests pass
- [ ] Added tests for new functionality
- [ ] Tested manually with sample Rails app
- [ ] Verified backward compatibility

## Breaking Changes
List any breaking changes and migration instructions.

Fixes #123
```

## Style Guidelines

### Ruby Code Style

This project follows the RuboCop configuration it provides:

```bash
# Check your code style
bundle exec rubocop

# Auto-fix style issues
bundle exec rubocop --autocorrect
```

### Configuration Guidelines

When modifying RuboCop configurations:

1. **Document changes** - Explain why a rule is enabled/disabled
2. **Provide examples** - Show good and bad code examples
3. **Consider impact** - Think about how changes affect existing codebases
4. **Test thoroughly** - Validate with real-world code

### Commit Message Guidelines

Follow conventional commit format:

- `fix: description` - Bug fixes
- `feat: description` - New features
- `docs: description` - Documentation changes
- `style: description` - Code style changes
- `refactor: description` - Code refactoring
- `test: description` - Test improvements
- `chore: description` - Maintenance tasks

## Release Process

### Version Management

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** (x.0.0) - Breaking changes
- **MINOR** (0.x.0) - New features (backward compatible)
- **PATCH** (0.0.x) - Bug fixes (backward compatible)

### Release Workflow

1. **Update CHANGELOG.md** - Document all changes
2. **Update version** - Bump version in `lib/rubocop/hk/version.rb`
3. **Create release** - Tag and push to trigger automated release
4. **Publish** - Automated GitHub Actions handles gem publishing

## Community

### Getting Help

- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Email**: Contact maintainer at hammadkhanxcm@gmail.com

### Maintainer Response

We aim to:
- **Acknowledge issues** within 48 hours
- **Review PRs** within 1 week
- **Release updates** monthly (or as needed for urgent fixes)

### Recognition

All contributors are recognized in our release notes and GitHub contributors list. Significant contributions may be highlighted in the README.

## FAQ

### Q: How do I propose a new RuboCop rule?
A: Open an issue with the cop name, rationale, and code examples. We'll discuss whether it fits the project's philosophy.

### Q: Can I disable a rule I disagree with?
A: Yes! Users can override any rule in their `.rubocop.yml`. If a rule is commonly disabled, we may reconsider its inclusion.

### Q: How do I test with different Ruby/Rails versions?
A: Use GitHub Actions or local testing with tools like `rbenv` and different Rails app versions.

### Q: What's the project's philosophy on rules?
A: We aim for practical, modern Ruby/Rails development with reasonable flexibility. Performance and readability are priorities.

---

## Thank You! 🎉

Thank you for contributing to RuboCop HK! Every contribution, no matter how small, helps improve the Ruby community's development experience.

**Happy coding!** 🚀