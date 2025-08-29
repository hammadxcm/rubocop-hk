# 📚 Usage Guide - RuboCop HK

> **Comprehensive usage examples and scenarios for RuboCop HK**  
> **🆕 v1.2.1: Includes warning-only modern rules and team adoption workflows**

<div align="center">

[![Back to README](https://img.shields.io/badge/←_Back_to-README-blue.svg)](README.md)
[![Quick Start](https://img.shields.io/badge/⚡_Quick-Start-green.svg)](QUICK_START.md)
[![Customization](https://img.shields.io/badge/⚙️-Customization-orange.svg)](CUSTOMIZATION.md)

</div>

---

## 📋 Table of Contents

- [🎯 Basic Usage](#-basic-usage)
- [🆕 Modern Rules Usage (v1.2.1)](#-modern-rules-usage-v120)
- [🚀 Command Line Options](#-command-line-options)
- [📁 Project Scenarios](#-project-scenarios)
- [🔧 Configuration Examples](#-configuration-examples)
- [🧪 Testing Integration](#-testing-integration)
- [📈 CI/CD Integration](#-cicd-integration)
- [🎨 Code Examples](#-code-examples)
- [🔄 Migration Strategies](#-migration-strategies)
- [⚡ Performance Optimization](#-performance-optimization)
- [🛠️ Troubleshooting](#️-troubleshooting)

---

## 🎯 Basic Usage

### 📦 **Standard Ruby Project**

```bash
# 1. Create .rubocop.yml
cat << 'EOF' > .rubocop.yml
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2
EOF

# 2. Check your code
bundle exec rubocop

# 3. Auto-fix issues
bundle exec rubocop --autocorrect-all
```

### 🚂 **Rails Application**

```bash
# 1. Enhanced Rails configuration
cat << 'EOF' > .rubocop.yml
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2
  TargetRailsVersion: 8.0
  NewCops: enable
  
  # Exclude Rails-generated files
  Exclude:
    - 'db/schema.rb'
    - 'db/migrate/*.rb'
    - 'config/boot.rb'
    - 'config/environment.rb'
    - 'config/environments/*.rb'
    - 'config/initializers/*.rb'
EOF

# 2. Check with Rails context
bundle exec rubocop
```

### 💎 **Gem Development**

```bash
# 1. Gem-specific configuration
cat << 'EOF' > .rubocop.yml
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1  # Support wider Ruby versions for gems
  
  Exclude:
    - 'spec/fixtures/**/*'
    - 'vendor/**/*'

# Relax some rules for gem development
Style/Documentation:
  Enabled: true  # Enable for public APIs

Metrics/BlockLength:
  Exclude:
    - 'spec/**/*'
    - '*.gemspec'
EOF

# 2. Run with specific focus on public APIs
bundle exec rubocop --only Style/Documentation lib/
```

---

## 🚀 Command Line Options

### 🎯 **Essential Commands**

```bash
# 🔍 Basic inspection
bundle exec rubocop                           # Check all files
bundle exec rubocop app/                      # Check specific directory
bundle exec rubocop app/models/user.rb       # Check specific file

# ⚡ Auto-correction
bundle exec rubocop --autocorrect             # Safe auto-corrections only
bundle exec rubocop --autocorrect-all         # All auto-corrections (use carefully)
bundle exec rubocop -A                        # Shorthand for --autocorrect-all

# 📊 Different output formats
bundle exec rubocop --format progress         # Show progress bar
bundle exec rubocop --format simple           # Minimal output
bundle exec rubocop --format json             # Machine-readable JSON
bundle exec rubocop --format html             # HTML report
```

### 📋 **Reporting & Analysis**

```bash
# 📊 Generate comprehensive reports
bundle exec rubocop --format html --out rubocop-report.html

# 📈 Statistics and metrics
bundle exec rubocop --format clang           # Compiler-like format
bundle exec rubocop --format fuubar          # Progress bar with details

# 🎯 Focus on specific issues
bundle exec rubocop --only Style/StringLiterals
bundle exec rubocop --except Style/Documentation
bundle exec rubocop --only Layout,Style      # Multiple departments
```

### 🔧 **Configuration & Setup**

```bash
# 📋 Generate TODO list for legacy projects
bundle exec rubocop --auto-gen-config

# 🔍 Show configuration for specific files
bundle exec rubocop --show-cops               # List all available cops
bundle exec rubocop --show-docs-url           # Show documentation URLs

# 🚀 Performance options
bundle exec rubocop --parallel               # Use multiple processors
bundle exec rubocop --cache                  # Enable caching (default)
bundle exec rubocop --no-cache               # Disable caching
```

---

## 📁 Project Scenarios

### 🆕 **New Project Setup**

<details>
<summary><strong>🏗️ Fresh Rails 7+ Application</strong></summary>

```bash
# Step 1: Rails application with modern setup
rails new awesome_app --ruby=3.2 --database=postgresql

cd awesome_app

# Step 2: Add RuboCop HK to Gemfile
cat << 'EOF' >> Gemfile

# Code quality and style
group :development, :test do
  gem 'rubocop-hk', '~> 1.0.9', require: false
end
EOF

# Step 3: Install and configure
bundle install

cat << 'EOF' > .rubocop.yml
# 🚂 Modern Rails Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2
  TargetRailsVersion: 8.0
  NewCops: enable

# Rails-specific optimizations
Rails/ApplicationController:
  Enabled: true
  
Rails/ApplicationRecord:
  Enabled: true
EOF

# Step 4: Initial code check and cleanup
bundle exec rubocop --autocorrect-all

# Step 5: Set up automatic formatting after generators
echo "Rails.application.configure do
  config.generators.apply_rubocop_autocorrect_after_generate! if Rails.env.development?
end" >> config/environments/development.rb
```

</details>

<details>
<summary><strong>📚 Ruby Library/Gem Project</strong></summary>

```bash
# Step 1: Create gem structure
bundle gem my_awesome_gem --mit --test=rspec --ci=github --coc

cd my_awesome_gem

# Step 2: Add RuboCop HK
cat << 'EOF' >> my_awesome_gem.gemspec

  # Development dependencies
  spec.add_development_dependency "rubocop-hk", "~> 1.0.9"
EOF

# Step 3: Configure for gem development
cat << 'EOF' > .rubocop.yml
# 💎 Gem Development Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1  # Support wider range for gems
  NewCops: enable

# Gem-specific settings
Style/Documentation:
  Enabled: true           # Important for public gems
  
Gemspec/RequiredRubyVersion:
  Enabled: true
  
Metrics/BlockLength:
  Exclude:
    - 'spec/**/*'
    - '*.gemspec'
    - 'Rakefile'
EOF

# Step 4: Setup development environment
bundle install
bundle exec rubocop --autocorrect-all
```

</details>

### 🔄 **Legacy Project Migration**

<details>
<summary><strong>📦 Large Legacy Rails Application</strong></summary>

```bash
# Step 1: Backup existing configuration
[ -f .rubocop.yml ] && cp .rubocop.yml .rubocop.yml.backup

# Step 2: Add RuboCop HK gradually
bundle add rubocop-hk --group development,test --require false

# Step 3: Create conservative configuration
cat << 'EOF' > .rubocop.yml
# 🔄 Legacy Project Migration Configuration
inherit_gem:
  rubocop-hk: config/default.yml

# Start with TODO file for gradual adoption
inherit_from: .rubocop_todo.yml

AllCops:
  TargetRubyVersion: 3.1    # Adjust to your current version
  TargetRailsVersion: 7.0   # Adjust to your Rails version
  NewCops: disable          # Don't enable new cops automatically
  
  # Exclude large/generated files initially
  Exclude:
    - 'db/**/*'
    - 'config/**/*'
    - 'vendor/**/*'
    - 'public/**/*'
    - 'log/**/*'
    - 'tmp/**/*'
    - 'storage/**/*'
EOF

# Step 4: Generate TODO file
bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000

# Step 5: Safe auto-corrections first
bundle exec rubocop --autocorrect --safe

# Step 6: Gradual improvement plan
echo "# 📈 RuboCop Improvement Plan

## Phase 1: Safe Auto-corrections (Week 1)
- Run: bundle exec rubocop --autocorrect --safe
- Focus: Layout, simple style fixes

## Phase 2: Manual Style Improvements (Week 2-3)  
- Enable: Style department rules one by one
- Fix: String literals, hash syntax, etc.

## Phase 3: Rails Best Practices (Week 4-5)
- Enable: Rails-specific cops
- Refactor: Controllers, models, helpers

## Phase 4: Code Quality (Week 6+)
- Enable: Metrics, complexity rules
- Refactor: Long methods, large classes" > RUBOCOP_MIGRATION_PLAN.md
```

</details>

---

## 🔧 Configuration Examples

### 🎛️ **Team-Specific Configurations**

<details>
<summary><strong>👥 Startup Team (Move Fast, Break Things)</strong></summary>

```yaml
# .rubocop.yml - Startup Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2
  TargetRailsVersion: 8.0
  
# Relaxed rules for rapid development
Metrics/AbcSize:
  Max: 25                 # Allow more complex methods initially

Metrics/ClassLength:
  Max: 200               # Bigger classes OK for MVPs

Style/Documentation:
  Enabled: false         # Skip docs for internal tools

Layout/LineLength:
  Max: 120              # Longer lines for productivity

# But enforce critical rules
Rails/Output:
  Enabled: true         # No puts in production code

Security/Eval:
  Enabled: true         # Always check security
```

</details>

<details>
<summary><strong>🏢 Enterprise Team (Strict Standards)</strong></summary>

```yaml
# .rubocop.yml - Enterprise Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2  # Conservative Ruby version
  TargetRailsVersion: 7.0
  NewCops: enable

# Strict documentation requirements
Style/Documentation:
  Enabled: true
  RequireForNonPublicMethods: true

# Strict complexity limits
Metrics/AbcSize:
  Max: 15

Metrics/CyclomaticComplexity:
  Max: 6

Metrics/MethodLength:
  Max: 10

# Security-first approach
Security:
  Enabled: true

# Consistent naming conventions
Naming/VariableNumber:
  EnforcedStyle: snake_case
```

</details>

<details>
<summary><strong>🧪 Open Source Project</strong></summary>

```yaml
# .rubocop.yml - Open Source Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1  # Support wider Ruby versions
  NewCops: enable

# Documentation is crucial for OSS
Style/Documentation:
  Enabled: true
  
# Encourage best practices
Style/StringLiterals:
  EnforcedStyle: double_quotes
  
# Be inclusive with contributions
Metrics/ClassLength:
  Max: 150
  
Layout/LineLength:
  Max: 100              # GitHub-friendly line length

# Test files can be more flexible
RSpec/ExampleLength:
  Max: 25
  
RSpec/MultipleExpectations:
  Max: 5
```

</details>

---

## 🧪 Testing Integration

### 🔬 **RSpec Configuration**

```ruby
# spec/spec_helper.rb
RSpec.configure do |config|
  # Add RuboCop checks as part of test suite
  config.before(:suite) do
    puts "🔍 Running RuboCop checks..."
    system("bundle exec rubocop --format simple") || puts("⚠️  RuboCop found issues")
  end
end
```

### 📊 **Test-Specific Rules**

```yaml
# .rubocop.yml - Testing configuration
RSpec/ExampleLength:
  Max: 20                    # Allow longer test examples

RSpec/MultipleExpectations:
  Max: 3                     # Limit expectations per test

RSpec/NestedGroups:
  Max: 4                     # Control nesting depth

RSpec/DescribeClass:
  Enabled: true              # Enforce proper test structure
  
# Factory files exceptions
RSpec/EmptyExampleGroup:
  Exclude:
    - 'spec/factories/**/*'
    
# Feature test exceptions  
RSpec/ScenarioLength:
  Exclude:
    - 'spec/features/**/*'
```

### 🏭 **Factory Configuration**

```ruby
# spec/factories/users.rb - RuboCop compliant factory
FactoryBot.define do
  factory :user do
    name { "John Doe" }              # Double quotes
    email { "john@example.com" }     # Consistent style
    role { "user" }
    
    trait :admin do
      role { "admin" }
    end
    
    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 3, user: user)
      end
    end
  end
end
```

---

## 📈 CI/CD Integration

### 🤖 **GitHub Actions Complete Setup**

```yaml
# .github/workflows/ci.yml
name: 🧪 Continuous Integration

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  rubocop:
    name: 🔧 RuboCop Analysis
    runs-on: ubuntu-latest
    
    steps:
    - name: 📥 Checkout Code
      uses: actions/checkout@v4
      
    - name: 💎 Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2
        bundler-cache: true
        
    - name: 🔍 Run RuboCop
      run: |
        bundle exec rubocop \
          --format github \
          --format json \
          --out tmp/rubocop-results.json
          
    - name: 📊 Upload Results  
      uses: actions/upload-artifact@v3
      if: always()
      with:
        name: rubocop-results
        path: tmp/rubocop-results.json
        
    - name: 💬 Comment on PR
      if: github.event_name == 'pull_request' && failure()
      uses: actions/github-script@v6
      with:
        script: |
          const fs = require('fs');
          const results = JSON.parse(fs.readFileSync('tmp/rubocop-results.json'));
          
          if (results.summary.offense_count > 0) {
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: `🔧 RuboCop found ${results.summary.offense_count} issues that need attention.`
            });
          }

  tests:
    name: 🧪 Test Suite
    runs-on: ubuntu-latest
    needs: rubocop  # Only run tests if RuboCop passes
    
    steps:
    - name: 📥 Checkout Code
      uses: actions/checkout@v4
      
    - name: 💎 Setup Ruby  
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2
        bundler-cache: true
        
    - name: 🧪 Run Tests
      run: bundle exec rspec
```

### 📋 **Pre-commit Configuration**

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: rubocop-autocorrect
        name: 🔧 RuboCop Auto-correct
        entry: bundle exec rubocop --autocorrect --fail-level error
        language: system
        types: [ruby]
        pass_filenames: false
        
      - id: rubocop-check
        name: 🔍 RuboCop Check
        entry: bundle exec rubocop --fail-level warning
        language: system
        types: [ruby]
        pass_filenames: false
```

---

## 🎨 Code Examples

### ✨ **Before & After Examples**

#### **String Literals**

```ruby
# ❌ Before: Inconsistent quotes
user_name = 'John Doe'
greeting = 'Hello, ' + user_name + '!'
file_path = '/path/to/file'

# ✅ After: Consistent double quotes
user_name = "John Doe"
greeting = "Hello, #{user_name}!"
file_path = "/path/to/file"
```

#### **Method Definitions**

```ruby
# ❌ Before: Inconsistent parentheses
def calculate_total items, tax_rate=0.08
  subtotal = items.map{|item| item.price}.sum
  subtotal + (subtotal * tax_rate)
end

def get_users
  User.where(active: true)
end

# ✅ After: Consistent style
def calculate_total(items, tax_rate = 0.08)
  subtotal = items.map { |item| item.price }.sum
  subtotal + (subtotal * tax_rate)
end

def get_users()
  User.where(active: true)
end
```

#### **Hash and Array Formatting**

```ruby
# ❌ Before: Inconsistent formatting
user_data = {name: 'John', email: 'john@example.com', role: 'admin'}

tags = ['ruby', 'rails', 'programming']

# ✅ After: Consistent trailing commas and formatting
user_data = {
  name: "John",
  email: "john@example.com", 
  role: "admin",
}

tags = [
  "ruby",
  "rails",
  "programming",
]
```

#### **Rails-Specific Improvements**

```ruby
# ❌ Before: Rails anti-patterns (pre-Rails 8)
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :json => {
      :name => @user.name,
      :email => @user.email
    }
  end
end

# ✅ After: Modern Rails 8 best practices
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  
  def show
    render json: {
      name: @user.name,
      email: @user.email,
      created_at: @user.created_at.iso8601,
    }, status: :ok
  end
  
  private
  
  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end
  
  def authenticate_user!
    # Rails 8 authentication pattern
    Current.user = User.find_by(session_token: session[:session_token])
    redirect_to login_path unless Current.user
  end
end
```

### 🏗️ **Architecture Examples**

#### **Service Objects**

```ruby
# ✅ Modern Rails 8 service object with encrypted attributes
class UserRegistrationService
  include ActiveModel::Validations
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }
  
  def initialize(user_params)
    @user_params = user_params
    @email = user_params[:email]
    @password = user_params[:password]
  end
  
  def call
    return failure(errors.full_messages) unless valid?
    
    ActiveRecord::Base.transaction do
      user = create_user_with_encryption
      return failure(user.errors.full_messages) unless user.persisted?
      
      create_session_token(user)
      send_welcome_email_async(user)
      success(user)
    end
  rescue ActiveRecord::RecordInvalid => e
    failure(e.message)
  end
  
  private
  
  attr_reader :user_params, :email, :password
  
  def create_user_with_encryption
    User.create!(
      email: email,
      password: password,
      password_confirmation: password,
      # Rails 7.1+ encrypted attribute
      personal_data: encrypt_personal_data,
      # Rails 8 authentication token
      session_token: generate_secure_token,
    )
  end
  
  def encrypt_personal_data
    # Use Rails 7.1+ encrypted attributes
    {
      signup_ip: Current.request_ip,
      user_agent: Current.user_agent,
      signup_time: Time.current.iso8601,
    }
  end
  
  def create_session_token(user)
    user.regenerate_session_token
    Current.user = user
  end
  
  def generate_secure_token
    # Rails 8 secure token generation
    SecureRandom.alphanumeric(32)
  end
  
  def send_welcome_email_async(user)
    # Modern ActiveJob pattern
    UserMailer.welcome_email(user).deliver_later(
      queue: :mailers,
      priority: 10,
      retry_on: Net::SMTPServerBusy,
      discard_on: Net::SMTPSyntaxError,
    )
  end
  
  def success(user)
    { 
      success: true, 
      user: user,
      session_token: user.session_token,
      authenticated: true,
    }
  end
  
  def failure(message)
    { 
      success: false, 
      error: Array.wrap(message).first,
      errors: Array.wrap(message),
      authenticated: false,
    }
  end
end
```

---

## 🔄 Migration Strategies

### 📈 **Gradual Adoption Plan**

#### **Week 1: Foundation**
```bash
# Focus on safe, automatic fixes
bundle exec rubocop --autocorrect --safe

# Key areas:
# - Layout issues (spacing, indentation)
# - Simple style fixes (quotes, parentheses)
# - Trailing whitespace
```

#### **Week 2-3: Style Consistency**
```bash
# Enable style cops gradually
bundle exec rubocop --only Style/StringLiterals --autocorrect
bundle exec rubocop --only Style/HashSyntax --autocorrect
bundle exec rubocop --only Style/TrailingCommaInHashLiteral --autocorrect

# Manual review required:
# - Method naming conventions
# - Variable naming
# - Class structure
```

#### **Week 4-5: Rails Best Practices**  
```bash
# Enable Rails cops
bundle exec rubocop --only Rails --autocorrect

# Focus areas:
# - Controller conventions
# - Model validations
# - Route definitions
# - View helpers
```

#### **Week 6+: Code Quality**
```bash
# Enable complexity metrics
bundle exec rubocop --only Metrics

# Refactoring targets:
# - Long methods (> 10 lines)
# - Complex classes (> 100 lines)  
# - High cyclomatic complexity
```

### 🎯 **Team Adoption Strategy**

#### **Phase 1: Team Agreement**
- Review RuboCop HK style guide together
- Discuss team-specific preferences
- Set up shared configuration
- Train on common patterns

#### **Phase 2: Tooling Setup**
- Configure editors for automatic formatting
- Set up pre-commit hooks
- Integrate with CI/CD pipeline
- Create team documentation

#### **Phase 3: Enforcement**
- Enable CI checks that block merge
- Regular code review focusing on style
- Weekly RuboCop reports
- Celebrate improvements

---

## ⚡ Performance Optimization

### 🚀 **Speed Up RuboCop**

```bash
# 🔥 Fastest configuration for large projects
bundle exec rubocop \
  --cache \                    # Enable caching (default)
  --parallel \                 # Use all CPU cores
  --format simple \            # Minimal output
  --fail-level error          # Only fail on errors

# 📊 Measure performance
time bundle exec rubocop --cache --parallel

# 🧹 Clear cache if issues
rm -rf ~/.cache/rubocop_cache/
```

### 🎛️ **Selective Execution**

```bash
# 🎯 Check only changed files in git
git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs bundle exec rubocop

# 📁 Focus on specific directories during development
bundle exec rubocop app/models/
bundle exec rubocop app/controllers/
bundle exec rubocop lib/

# 🔍 Target specific cop categories
bundle exec rubocop --only Layout     # Fast layout checks
bundle exec rubocop --only Style      # Style consistency
```

### 📈 **Configuration Optimization**

```yaml
# .rubocop.yml - Performance optimized
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  # Exclude large files from analysis  
  Exclude:
    - 'db/schema.rb'
    - 'node_modules/**/*'
    - 'vendor/**/*'
    - 'coverage/**/*'
  
  # Cache configuration
  UseCache: true
  CacheRootDirectory: ~/.cache/rubocop_cache
  
  # Parallel processing
  DefaultFormatter: progress
  
# Disable expensive cops for development
Layout/LineLength:
  Enabled: false              # Disable during rapid development

Metrics/AbcSize:
  Enabled: false              # Re-enable before commits
```

---

## 🛠️ Troubleshooting

### 🚨 **Common Issues & Solutions**

#### **Configuration Problems**

<details>
<summary><strong>❌ "Configuration file not found"</strong></summary>

```bash
# Problem
Configuration file not found: config/default.yml

# Solution: Check .rubocop.yml syntax
inherit_gem:
  rubocop-hk: config/default.yml  # No quotes around path!

# Verify gem installation
bundle list | grep rubocop-hk
gem list rubocop-hk
```

</details>

<details>
<summary><strong>❌ "Unknown cop" errors</strong></summary>

```bash
# Problem  
Unknown cop 'Style/SomeNewCop'

# Solution: Update gem and enable new cops cautiously
bundle update rubocop-hk

# Add to .rubocop.yml
AllCops:
  NewCops: disable  # Control new cop adoption
```

</details>

#### **Performance Issues**

<details>
<summary><strong>🐌 "RuboCop running slowly"</strong></summary>

```bash
# Solutions:
# 1. Enable caching and parallel processing
bundle exec rubocop --cache --parallel

# 2. Exclude large files
echo "AllCops:
  Exclude:
    - 'db/schema.rb'
    - 'vendor/**/*'" >> .rubocop.yml

# 3. Use selective checking
bundle exec rubocop --only Layout,Style

# 4. Clear cache if corrupted
rm -rf ~/.cache/rubocop_cache/
```

</details>

#### **Team Integration Issues**

<details>
<summary><strong>👥 "Team members getting different results"</strong></summary>

```bash
# Solutions:
# 1. Lock gem versions
echo 'gem "rubocop-hk", "~> 1.0.9"' >> Gemfile
bundle lock

# 2. Share exact configuration
git add .rubocop.yml
git commit -m "Add shared RuboCop configuration"

# 3. Document team setup
echo "# Team Setup
bundle install
bundle exec rubocop --autocorrect-all" > SETUP.md
```

</details>

### 🔧 **Advanced Troubleshooting**

#### **Debug Configuration**
```bash
# Show effective configuration for a file
bundle exec rubocop --show-cops | grep Style/StringLiterals

# Display configuration used
bundle exec rubocop --debug app/models/user.rb
```

#### **Isolate Issues**
```bash
# Test with minimal config
echo "inherit_gem:
  rubocop-hk: config/default.yml" > .rubocop.test.yml

bundle exec rubocop --config .rubocop.test.yml
```

#### **Performance Profiling**
```bash
# Profile RuboCop execution
bundle exec rubocop --profile | head -20

# Identify slow cops
time bundle exec rubocop --only Style/StringLiterals
time bundle exec rubocop --only Layout/LineLength
```

---

## 📚 Additional Resources

### 🔗 **Quick Links**
- **[📋 Quick Start Guide](QUICK_START.md)** - Get started in minutes
- **[⚙️ Customization Guide](CUSTOMIZATION.md)** - Advanced configuration
- **[🎨 Style Guide](STYLEGUIDE.md)** - Complete coding standards
- **[🤝 Contributing](CONTRIBUTING.md)** - How to contribute

### 📖 **External Documentation**
- **[RuboCop Official Docs](https://docs.rubocop.org/)** - Complete RuboCop reference
- **[Ruby Style Guide](https://rubystyle.guide/)** - Community standards
- **[Rails Guides](https://guides.rubyonrails.org/)** - Rails conventions

### 💬 **Community & Support**
- **[GitHub Issues](https://github.com/hammadxcm/rubocop-hk/issues)** - Bug reports & features
- **[GitHub Discussions](https://github.com/hammadxcm/rubocop-hk/discussions)** - Questions & ideas
- **[RuboCop Slack](https://join.slack.com/t/rubocop/shared_invite/)** - General RuboCop community

---

<div align="center">

**🎉 Happy coding with RuboCop HK! 🎉**

[![Back to Top](https://img.shields.io/badge/⬆️_Back_to-Top-blue.svg)](#-usage-guide---rubocop-hk)
[![README](https://img.shields.io/badge/←_Back_to-README-green.svg)](README.md)

</div>