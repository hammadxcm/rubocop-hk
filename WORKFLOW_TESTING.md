# 🧪 GitHub Actions Workflow Testing

This guide shows you how to test your GitHub Actions workflows locally before pushing, ensuring they'll pass in CI.

## 🚀 Quick Testing

### Using the Pre-Push Script (Recommended)

```bash
# Test all workflows before pushing
./scripts/pre-push-test.sh
```

### Using Make Commands

```bash
# Test all workflows  
make test-workflows

# Individual components
make test           # Run tests + linting
make security       # Security audit
make build         # Build gem
```

## 📋 What Gets Tested

The pre-push script validates all GitHub Actions workflow components:

| Test | Workflow | Description |
|------|----------|-------------|
| 1️⃣ **Dependencies** | CI | `bundle install` and dependency resolution |
| 2️⃣ **Tests** | CI | Complete RSpec test suite (118 examples) |
| 3️⃣ **Linting** | CI | RuboCop static code analysis |
| 4️⃣ **Security** | Security | bundler-audit vulnerability scanning |
| 5️⃣ **Configuration** | CI | YAML syntax + RuboCop config loading |
| 6️⃣ **Build** | Release | Gem building and installation |
| 7️⃣ **Workflow Syntax** | All | GitHub Actions YAML validation |

## 🔍 Manual Testing

You can also test individual components manually:

### CI Workflow Testing

```bash
# Test like GitHub Actions CI
bundle install
bundle exec rspec --format progress
bundle exec rubocop --parallel

# Test configuration loading
bundle exec ruby -e "
  require 'rubocop'
  config = RuboCop::ConfigLoader.load_file('./config/default.yml')
  puts 'Configuration loaded successfully'
"
```

### Security Workflow Testing

```bash
# Install security tools
gem install bundler-audit

# Run security audit
bundler-audit update
bundler-audit check

# Run security cops
bundle exec rubocop --only Security
```

### Release Workflow Testing

```bash
# Test gem build and install
gem build rubocop-hk.gemspec
gem install ./rubocop-hk-1.0.9.gem

# Test gem functionality
ruby -e "require 'rubocop/hk'; puts Rubocop::Hk::VERSION"
```

## 🛠️ Advanced Testing with `act`

If you have Docker and want full GitHub Actions simulation:

### Install act

```bash
# macOS
brew install act

# Linux
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

### Run Workflows

```bash
# List all workflows
act --list

# Run CI workflow
act -W .github/workflows/ci.yml

# Run security workflow  
act -W .github/workflows/security.yml

# Run specific job
act -W .github/workflows/ci.yml -j lint
```

## 🚨 Troubleshooting

### Common Issues

**Dependencies fail to install:**
```bash
bundle clean --force
bundle install
```

**Tests fail:**
```bash
# Check specific test failures
bundle exec rspec --format documentation

# Update test expectations if needed
```

**RuboCop violations:**
```bash
# See detailed violations
bundle exec rubocop --format offense_count

# Auto-fix safe violations
bundle exec rubocop --autocorrect
```

**Security vulnerabilities:**
```bash
# Update vulnerable gems
bundle update

# Check specific vulnerabilities
bundler-audit check --verbose
```

**Workflow syntax errors:**
```bash
# Validate YAML syntax
for f in .github/workflows/*.yml; do
  ruby -e "require 'yaml'; YAML.load_file('$f')" 
done
```

## 📈 Pre-Push Workflow

Integrate into your development workflow:

```bash
# Before every push
git add .
make test-workflows  # Ensure workflows will pass
git commit -m "feat: add new feature"
git push origin main
```

### Git Hook Integration

Add to `.git/hooks/pre-push`:

```bash
#!/bin/bash
echo "🧪 Running pre-push workflow tests..."
./scripts/pre-push-test.sh
```

## 🎯 CI/CD Best Practices

1. **Always test locally first** - Saves CI minutes and faster feedback
2. **Run security scans regularly** - Catch vulnerabilities early  
3. **Keep dependencies updated** - Use Dependabot or manual updates
4. **Monitor workflow performance** - Track CI execution times
5. **Test with multiple Ruby versions** - Ensure compatibility

## 📊 Workflow Status

Current workflow configurations test:

- ✅ **Ruby versions**: 3.2, 3.3, 3.4
- ✅ **Rails versions**: 7.0, 7.1, 7.2, 8.0  
- ✅ **Security scanning**: Daily vulnerability checks
- ✅ **Automated releases**: On version tags
- ✅ **Dependency updates**: Weekly Dependabot PRs

Your workflows are production-ready! 🚀