<div align="center">

# 🤝 Contributing to RuboCop HK

> **Thank you for your interest in making RuboCop HK even better!**  
> **🆕 v1.2.1: Now with 45+ warning-only modern rules and team adoption tooling**

[![GitHub Issues](https://img.shields.io/github/issues/hammadxcm/rubocop-hk.svg)](https://github.com/hammadxcm/rubocop-hk/issues)
[![GitHub PRs](https://img.shields.io/github/issues-pr/hammadxcm/rubocop-hk.svg)](https://github.com/hammadxcm/rubocop-hk/pulls)
[![Contributors](https://img.shields.io/github/contributors/hammadxcm/rubocop-hk.svg)](https://github.com/hammadxcm/rubocop-hk/graphs/contributors)

**[📋 Quick Setup](#-development-setup) • [🐛 Report Bugs](#-bug-reports) • [💡 Request Features](#-feature-requests) • [📖 Improve Docs](#-documentation-improvements)**

</div>

---

**Welcome to the RuboCop HK community! 🎉** This guide will help you get started with contributing to our open-source RuboCop configuration gem that's helping Ruby teams write better code worldwide.

## 📋 Table of Contents

- [✨ Getting Started](#-getting-started)
- [🆕 v1.2.1 Contribution Areas](#-v120-contribution-areas)
- [🛠️ Development Setup](#️-development-setup)
- [🤝 Making Contributions](#-making-contributions)
- [🧪 Testing](#-testing)
- [📤 Submitting Changes](#-submitting-changes)
- [🎨 Style Guidelines](#-style-guidelines)
- [👥 Community](#-community)
- [❓ FAQ](#-faq)

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
- **🆕 v1.2.1**: **45+ warning-only modern rules** with educational documentation and team adoption tooling

### 🌟 Ways to Contribute

<table>
<tr>
<td align="center" width="20%">

### 🐛 **Report Bugs**
Help us identify issues and improve stability

**[👉 Report Bug](https://github.com/hammadxcm/rubocop-hk/issues/new?template=bug_report.md)**

</td>
<td align="center" width="20%">

### 💡 **Suggest Features**
Propose new features or improvements

**[👉 Request Feature](https://github.com/hammadxcm/rubocop-hk/issues/new?template=feature_request.md)**

</td>
<td align="center" width="20%">

### 📖 **Improve Docs**
Help make our documentation clearer

**[👉 Edit Docs](https://github.com/hammadxcm/rubocop-hk/tree/main)**

</td>
<td align="center" width="20%">

### 🔧 **Fix Issues**
Submit pull requests for bug fixes

**[👉 View Issues](https://github.com/hammadxcm/rubocop-hk/issues)**

</td>
<td align="center" width="20%">

### 💬 **Help Others**
Answer questions and share knowledge

**[👉 Join Discussions](https://github.com/hammadxcm/rubocop-hk/discussions)**

</td>
</tr>
</table>

## 🆕 v1.2.1 Contribution Areas

### 🎯 **Modern Rules Development**

**New in v1.2.1**: We've introduced 45+ warning-only modern rules that need ongoing refinement and testing.

<table>
<tr>
<td width="25%">

#### **🎨 Style Rules**
- Ruby 3.3 modern patterns
- Argument forwarding
- Collection compacting
- Hash transformations

**Focus**: Clean, readable code

</td>
<td width="25%">

#### **🚄 Rails 8.0 Rules**
- Enum syntax compatibility
- Response parsing
- ActiveModel deprecations
- Modern Rails patterns

**Focus**: Rails 8.0+ readiness

</td>
<td width="25%">

#### **🧪 RSpec Rules**
- Modern matchers
- Better assertions
- Performance patterns
- Testing best practices

**Focus**: Quality test suites

</td>
<td width="25%">

#### **⚡ Performance Rules**
- Constant regexps
- Range optimizations
- Collection methods
- Memory efficiency

**Focus**: Fast Ruby code

</td>
</tr>
</table>

### 🛠️ **Team Adoption Tooling**

We need help improving our team-focused tooling:

- **scripts/promote-warnings.rb** - Warning promotion automation
- **Makefile commands** - Daily workflow integration
- **Educational content** - GRADUAL_ADOPTION_GUIDE.md and MODERN_RULES_REFERENCE.md
- **CI/CD integration** - GitHub Actions and other CI systems

### 📚 **Educational Content**

Help us create better educational materials:

- **Rule explanations** - Why each rule matters
- **Before/After examples** - Show the improvement
- **Team guides** - Sprint planning and retrospective integration
- **Code review templates** - Make adoption easier

## Development Setup

### Prerequisites

- **Ruby**: 3.3.0 or higher (**Updated for v1.2.1 modern rules**)
- **Bundler**: Latest version
- **Git**: For version control
- **Make**: For using team adoption commands (`make help`)

### ⚡ **Quick Setup (Copy & Paste)**

```bash
# 🍴 1. Fork the repo on GitHub, then clone your fork
git clone git@github.com:YOUR-USERNAME/rubocop-hk.git
cd rubocop-hk

# 📦 2. Install dependencies
bundle install

# ✅ 3. Verify everything works
bundle exec rspec && bundle exec rubocop

# 🆕 4. Try out the new v1.2.1 tooling
make help
make warning-summary
make check-warnings

# 🎉 5. You're ready to contribute!
echo "✨ Setup complete! Start coding..."
```

<details>
<summary><strong>🔧 Detailed Setup Steps</strong></summary>

1. **🍴 Fork the repository** on GitHub
   - Click the "Fork" button on the main repository page
   - This creates your own copy of the project

2. **📂 Clone your fork locally:**
   ```bash
   git clone git@github.com:YOUR-USERNAME/rubocop-hk.git
   cd rubocop-hk
   ```

3. **📦 Install dependencies:**
   ```bash
   bundle install
   ```

4. **✅ Verify your setup:**
   ```bash
   # Run the test suite
   bundle exec rspec
   
   # Run RuboCop on the codebase
   bundle exec rubocop
   
   # Test gem loading
   bundle exec ruby -e "require 'rubocop/hk'; puts 'Gem loaded successfully!'"
   ```

5. **🎯 Set up your development environment:**
   ```bash
   # Create a branch for your work
   git checkout -b feature/your-awesome-feature
   
   # Configure git (if not already done)
   git config user.name "Your Name"
   git config user.email "your.email@example.com"
   ```

</details>

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

# 🆕 Run integration tests for modern rules
bundle exec rspec spec/integration/modern_rules_spec.rb
bundle exec rspec spec/integration/warning_promotion_spec.rb

# Run with coverage
bundle exec rspec --format documentation

# 🆕 Test team adoption tooling
make check-warnings
make warning-summary
```

### Testing Your Changes

1. **Unit tests**: Ensure existing tests pass
2. **Manual testing**: Test your changes manually
3. **Integration testing**: Test with real Rails applications
4. **Multi-version testing**: Test across Ruby/Rails versions
5. **🆕 Modern rules testing**: Test warning-only behavior doesn't break builds
6. **🆕 Team tooling testing**: Verify Makefile commands work correctly
7. **🆕 Educational content**: Test documentation clarity with team members

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

We use [Conventional Commits](https://www.conventionalcommits.org/) for automated release management:

#### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Types
- `fix:` - Bug fixes (triggers PATCH version)
- `feat:` - New features (triggers MINOR version)
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, semicolons, etc.)
- `refactor:` - Code refactoring without feature changes
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks (dependencies, CI, etc.)
- `perf:` - Performance improvements
- `security:` - Security-related fixes

#### Breaking Changes
Use `!` after type or add `BREAKING CHANGE:` in footer (triggers MAJOR version):
```
feat!: change default configuration format
```

#### Examples
```bash
# Good examples
feat: add support for Rails 8.1 configuration
fix: resolve conflict with rubocop-performance 1.25
docs: update installation guide for Ruby 3.4
chore(deps): update rubocop to 1.80.0
```

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
A: Open an issue with the cop name, rationale, and code examples. We'll discuss whether it fits the project's philosophy. **New in v1.2.1**: Consider if it should be warning-only for gradual adoption.

### Q: Can I disable a rule I disagree with?
A: Yes! Users can override any rule in their `.rubocop.yml`. If a rule is commonly disabled, we may reconsider its inclusion.

### Q: How do I test with different Ruby/Rails versions?
A: Use GitHub Actions or local testing with tools like `rbenv` and different Rails app versions.

### Q: What's the project's philosophy on rules?
A: We aim for practical, modern Ruby/Rails development with reasonable flexibility. Performance and readability are priorities. **v1.2.1 adds**: Educational approach with warning-only modernization.

### 🆕 Q: Why are the new modern rules warning-only?
A: Warning-only rules prevent build failures while educating teams about modern patterns. Teams can promote warnings to errors when ready using `make promote COPS=...`.

### 🆕 Q: How do I contribute to the educational documentation?
A: Help improve GRADUAL_ADOPTION_GUIDE.md and MODERN_RULES_REFERENCE.md. Focus on clear explanations and practical examples.

### 🆕 Q: How do I test the team adoption tooling?
A: Run `make help` to see all available commands. Test `make warning-summary`, `make check-warnings`, and `make promote COPS=...` with different configurations.

### 🆕 Q: Can I contribute new team workflow commands?
A: Absolutely! Add new commands to the Makefile with clear documentation. Focus on daily developer workflows and team coordination.

---

## Thank You! 🎉

Thank you for contributing to RuboCop HK! Every contribution, no matter how small, helps improve the Ruby community's development experience.

**Happy coding!** 🚀