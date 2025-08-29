# ⚙️ Customization Guide - RuboCop HK

> **Advanced configuration options and team-specific customizations for RuboCop HK**  
> **🆕 v1.2.0: Customize warning-only modern rules and team adoption workflows**

<div align="center">

[![Gem Version](https://badge.fury.io/rb/rubocop-hk.svg)](https://badge.fury.io/rb/rubocop-hk)
[![Configuration](https://img.shields.io/badge/config-customizable-blue.svg)]()
[![Teams](https://img.shields.io/badge/team-friendly-green.svg)]()

**[📚 Back to README](README.md) • [⚡ Quick Start](QUICK_START.md) • [📖 Usage Guide](USAGE.md)**

</div>

---

## 📋 Table of Contents

- [🎯 Configuration Basics](#-configuration-basics)
- [🆕 Modern Rules Customization (v1.2.0)](#-modern-rules-customization-v120)
- [🏢 Team-Specific Configurations](#-team-specific-configurations)  
- [📊 Cop Categories](#-cop-categories)
- [🎛️ Advanced Settings](#️-advanced-settings)
- [🚂 Rails Customizations](#-rails-customizations)
- [🧪 Testing Configurations](#-testing-configurations)
- [🔧 Editor Integration](#-editor-integration)
- [📈 CI/CD Customizations](#-cicd-customizations)
- [🎨 Style Customizations](#-style-customizations)
- [📦 Project Type Templates](#-project-type-templates)
- [🛠️ Warning Promotion Workflow](#️-warning-promotion-workflow)

---

## 🎯 Configuration Basics

### 📁 **Configuration File Structure**

```yaml
# .rubocop.yml - Complete structure
# 🔗 Inheritance from RuboCop HK
inherit_gem:
  rubocop-hk: config/default.yml

# 📋 Additional local configurations  
inherit_from:
  - .rubocop_local.yml      # Team-specific overrides
  - .rubocop_todo.yml       # Generated TODO items

# 🎯 Global settings
AllCops:
  TargetRubyVersion: 3.3    # Your Ruby version
  TargetRailsVersion: 7.0   # Your Rails version (if applicable)
  NewCops: enable           # Handle new cops
  
  # 📁 Exclude patterns
  Exclude:
    - "vendor/**/*"
    - "db/schema.rb"
    - "node_modules/**/*"
  
  # 📂 Include additional Ruby files
  Include:
    - "**/*.rb"
    - "**/Rakefile"
    - "**/config.ru"

# 🎨 Department-specific settings  
Style:
  Enabled: true

Rails:
  Enabled: true

# 🔧 Individual cop configurations
Style/StringLiterals:
  EnforcedStyle: double_quotes

Layout/LineLength:
  Max: 120
```

### 🔗 **Inheritance Hierarchy**

```
📁 Your Project Configuration (.rubocop.yml)
├── 📦 RuboCop HK Default (config/default.yml)
│   ├── 🎨 Style Rules (config/rubocop-style.yml)
│   ├── 🚂 Rails Rules (config/rubocop-rails.yml)
│   ├── 🧪 RSpec Rules (config/rubocop-rspec.yml)
│   ├── 📐 Layout Rules (config/rubocop-layout.yml)
│   ├── 📊 Metrics Rules (config/rubocop-metrics.yml)
│   ├── 🐛 Lint Rules (config/rubocop-lint.yml)
│   └── ⚡ Performance Rules (config/rubocop-performance.yml)
├── 📋 Local Overrides (.rubocop_local.yml)
└── 📝 TODO Items (.rubocop_todo.yml)
```

---

## 🏢 Team-Specific Configurations

### 👥 **Startup Team (Fast Iteration)**

```yaml
# .rubocop.yml - Startup Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.3
  TargetRailsVersion: 7.0
  
# 🚀 Optimized for speed and iteration
Metrics/AbcSize:
  Max: 25                    # Allow more complex methods initially

Metrics/MethodLength:
  Max: 15                    # Longer methods OK for MVPs

Metrics/ClassLength:
  Max: 200                   # Larger classes during rapid prototyping

Style/Documentation:
  Enabled: false             # Skip documentation for internal tools

Layout/LineLength:
  Max: 120                   # Longer lines for productivity

# 🎯 But enforce critical rules
Security:
  Enabled: true              # Never compromise on security

Rails/Output:
  Enabled: true              # No debugging output in commits

Lint/Debugger:
  Enabled: true              # No debugger statements

# 🧪 Relaxed test rules  
RSpec/ExampleLength:
  Max: 25

RSpec/MultipleExpectations:
  Max: 5
```

### 🏢 **Enterprise Team (Strict Standards)**

```yaml
# .rubocop.yml - Enterprise Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2     # Conservative Ruby version
  TargetRailsVersion: 7.0
  NewCops: enable

# 📚 Comprehensive documentation requirements
Style/Documentation:
  Enabled: true
  RequireForNonPublicMethods: true

# 📊 Strict complexity limits
Metrics/AbcSize:
  Max: 15                    # Low complexity threshold

Metrics/CyclomaticComplexity:
  Max: 6                     # Simple logic flow

Metrics/MethodLength:
  Max: 10                    # Short methods

Metrics/ClassLength:
  Max: 100                   # Compact classes

Metrics/BlockLength:
  Max: 25
  Exclude:
    - "spec/**/*"            # Allow longer test blocks

# 🔒 Enhanced security focus
Security:
  Enabled: true
  AutoCorrect: false         # Manual review required

# 📝 Consistent naming conventions
Naming/VariableNumber:
  EnforcedStyle: snake_case

Naming/MethodName:
  EnforcedStyle: snake_case

# 🎨 Strict style enforcement
Style/TrailingCommaInArguments:
  EnforcedStyleForMultiline: comma

Style/TrailingCommaInArrayLiteral:
  EnforcedStyleForMultiline: comma

Style/TrailingCommaInHashLiteral:
  EnforcedStyleForMultiline: comma
```

### 🌍 **Open Source Project**

```yaml
# .rubocop.yml - Open Source Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1     # Support wider Ruby versions
  NewCops: enable
  
# 📖 Documentation is crucial for OSS
Style/Documentation:
  Enabled: true
  Exclude:
    - "spec/**/*"            # Not required for tests
    - "examples/**/*"        # Not required for examples

# 🤝 Inclusive contribution settings
Metrics/ClassLength:
  Max: 150                   # Reasonable for contributors

Layout/LineLength:
  Max: 100                   # GitHub-friendly

# 🧪 Test-friendly settings
RSpec/ExampleLength:
  Max: 25                    # Descriptive tests

RSpec/MultipleExpectations:
  Max: 5                     # Complex feature tests

RSpec/NestedGroups:
  Max: 4                     # Well-organized test structure

# 🌐 Multi-platform considerations
Style/FrozenStringLiteralComment:
  Enabled: true              # Performance across Ruby versions

# 🔧 Gem-specific settings
Gemspec/RequiredRubyVersion:
  Enabled: true

Gemspec/DuplicatedAssignment:
  Enabled: true
```

### 🎯 **API-First Team**

```yaml
# .rubocop.yml - API-First Configuration
inherit_gem:
  rubocop-hk: config/default.yml

# 🌐 API-specific optimizations
Rails/ApplicationController:
  Enabled: true

Rails/ApplicationRecord:
  Enabled: true

# 📊 JSON/API response formatting
Layout/MultilineHashBraceLayout:
  EnforcedStyle: new_line

Style/HashSyntax:
  EnforcedStyle: ruby19
  
# 🔒 API security focus
Security/JSONLoad:
  Enabled: true

Security/YAMLLoad:
  Enabled: true

# 📝 API documentation requirements
Style/Documentation:
  Enabled: true
  Exclude:
    - "app/models/**/*"      # May have external documentation
    - "spec/**/*"

# 🧪 API testing patterns
RSpec/InstanceVariable:
  Enabled: false             # Common in API tests

RSpec/NestedGroups:
  Max: 5                     # Complex API test scenarios
```

---

## 📊 Cop Categories

### 🎨 **Style Department**

Controls code appearance and Ruby idioms:

```yaml
# String literal preferences
Style/StringLiterals:
  EnforcedStyle: double_quotes        # 'single' or 'double_quotes'
  ConsistentQuotesInMultiline: true   # Consistent within multiline

# Hash syntax modernization  
Style/HashSyntax:
  EnforcedStyle: ruby19               # :symbol => vs symbol:
  EnforcedShorthandSyntax: always     # {a:, b:} vs {a: a, b: b}

# Method definition style
Style/DefWithParentheses:
  Enabled: true                       # def method() vs def method

# Conditional assignment
Style/ConditionalAssignment:
  EnforcedStyle: assign_to_condition  # x = if vs if; x = 

# Trailing commas
Style/TrailingCommaInArrayLiteral:
  EnforcedStyleForMultiline: comma    # [a, b,] vs [a, b]

Style/TrailingCommaInHashLiteral:
  EnforcedStyleForMultiline: comma    # {a: 1, b: 2,}

Style/TrailingCommaInArguments:
  EnforcedStyleForMultiline: comma    # method(a, b,)
```

### 📐 **Layout Department**

Manages whitespace, indentation, and code structure:

```yaml
# Line length limits
Layout/LineLength:
  Max: 120                            # Character limit per line
  AllowedPatterns:
    - '\A\s*#'                        # Allow long comments
    - '\A\s*it\s'                     # Allow long test descriptions

# Indentation settings
Layout/IndentationConsistency:
  EnforcedStyle: normal               # 'normal' or 'indented_internal_methods'

Layout/IndentationWidth:
  Width: 2                            # Spaces per indentation level

# Method spacing
Layout/EmptyLineAfterMagicComment:
  Enabled: true

Layout/EmptyLinesAroundMethodBody:
  Enabled: true

Layout/EmptyLinesAroundClassBody:
  EnforcedStyle: no_empty_lines       # 'empty_lines' or 'no_empty_lines'

# Alignment settings  
Layout/HashAlignment:
  EnforcedHashRocketStyle: table      # Hash rocket alignment
  EnforcedColonStyle: table          # Colon alignment

Layout/ParameterAlignment:
  EnforcedStyle: with_first_parameter # Parameter alignment style
```

### 📊 **Metrics Department**

Enforces complexity and size limits:

```yaml
# Method complexity
Metrics/AbcSize:
  Max: 20                             # Assignment/Branch/Condition complexity
  Exclude:
    - "db/migrate/**/*"               # Skip migrations

Metrics/CyclomaticComplexity:
  Max: 8                              # Number of decision points

Metrics/PerceivedComplexity:
  Max: 10                             # Complexity as perceived by humans

# Size limits
Metrics/MethodLength:
  Max: 15                             # Lines per method
  CountComments: false                # Exclude comments from count

Metrics/ClassLength:
  Max: 120                            # Lines per class
  CountComments: false

Metrics/ModuleLength:
  Max: 120                            # Lines per module

# Block complexity
Metrics/BlockLength:
  Max: 25                             # Lines per block
  Exclude:
    - "spec/**/*"                     # Exclude test files
    - "config/**/*"                   # Exclude config files
    - "*.gemspec"                     # Exclude gemspec
```

### 🐛 **Lint Department**

Catches potential bugs and issues:

```yaml
# Variable usage
Lint/UnusedBlockArgument:
  Enabled: true
  
Lint/UnusedMethodArgument:
  Enabled: true

# Control flow issues
Lint/UnreachableCode:
  Enabled: true

Lint/UselessAssignment:
  Enabled: true

# Ruby version compatibility
Lint/RequireParentheses:
  Enabled: true

# Security-related linting
Lint/Eval:
  Enabled: true

Lint/LiteralAsCondition:
  Enabled: true
```

### ⚡ **Performance Department**

Suggests performance optimizations:

```yaml
# String operations
Performance/StringReplacement:
  Enabled: true

Performance/RedundantStringChars:
  Enabled: true

# Collection operations  
Performance/CollectionLiteralInLoop:
  Enabled: true

Performance/TimesMap:
  Enabled: true

# Method chaining optimizations
Performance/ChainArrayAllocation:
  Enabled: true

Performance/ReverseEach:
  Enabled: true
```

---

## 🎛️ Advanced Settings

### 🎯 **Selective Cop Enabling**

```yaml
# Enable only specific departments
Style:
  Enabled: true

Layout:
  Enabled: true
  
Metrics:
  Enabled: false              # Disable complexity checks

# Enable specific cops from disabled departments
Metrics/AbcSize:
  Enabled: true               # Override department setting

# Disable specific cops from enabled departments  
Style/Documentation:
  Enabled: false              # Override department setting
```

### 📁 **Advanced Exclusion Patterns**

```yaml
AllCops:
  # 📂 File pattern exclusions
  Exclude:
    - "vendor/**/*"           # Third-party code
    - "db/schema.rb"          # Generated file
    - "bin/**/*"              # Executable scripts
    - "node_modules/**/*"     # Frontend dependencies
    - "coverage/**/*"         # Test coverage files
    - "public/assets/**/*"    # Compiled assets
    
  # 📋 Include additional file patterns
  Include:
    - "**/*.rb"               # Ruby files
    - "**/*.rake"             # Rake files
    - "**/Rakefile"           # Rakefile
    - "**/Gemfile"            # Gemfile
    - "**/*.gemspec"          # Gemspec files
    - "**/config.ru"          # Rack config

# 🎯 Cop-specific exclusions
Style/Documentation:
  Exclude:
    - "app/controllers/**/*"  # Controllers often self-documenting
    - "spec/**/*"             # Test files
    - "db/migrate/**/*"       # Migrations

Metrics/ClassLength:
  Exclude:
    - "app/models/concerns/**/*"  # Concerns can be longer
    - "lib/tasks/**/*"            # Task files
```

### 🔄 **Auto-correction Settings**

```yaml
# Global auto-correction settings
AllCops:
  SuggestExtensions: false    # Don't suggest RuboCop extensions
  
# Safe auto-corrections only
Layout/TrailingEmptyLines:
  AutoCorrect: true           # Always safe

# Unsafe auto-corrections
Style/RedundantReturn:
  AutoCorrect: false          # May change behavior
  
Security:
  AutoCorrect: false          # Security issues need manual review

# Department-level auto-correction
Layout:
  AutoCorrect: true           # Layout changes are usually safe

Style:
  AutoCorrect: true           # Most style changes are safe
  
Performance:
  AutoCorrect: false          # Performance changes need review
```

---

## 🚂 Rails Customizations

### 🛤️ **Rails-Specific Settings**

```yaml
# Rails department configuration
Rails:
  Enabled: true
  
Rails/ApplicationController:
  Enabled: true
  SafeAutoCorrect: true

Rails/ApplicationRecord:
  Enabled: true
  SafeAutoCorrect: true

# ActiveRecord best practices
Rails/ActiveRecordAliases:
  Enabled: true               # Prefer update over update_attributes

Rails/HasManyOrHasOneDependent:
  Enabled: true               # Require dependent: option

Rails/InverseOf:
  Enabled: true               # Use inverse_of for better performance

# View and helper conventions
Rails/ContentTag:
  Enabled: true               # Prefer tag helpers

Rails/LinkToBlank:
  Enabled: true               # Security for target: '_blank'

# Migration best practices
Rails/ReversibleMigration:
  Enabled: true               # Ensure migrations are reversible

Rails/BulkChangeTable:
  Enabled: true               # Use change_table for multiple changes
```

### 🎛️ **Rails Version-Specific Settings**

```yaml
# Rails 7.0+ specific configurations
AllCops:
  TargetRailsVersion: 7.0

# Rails 7+ features  
Rails/WhereExists:
  Enabled: true               # Use exists? instead of present?

Rails/WhereNot:
  Enabled: true               # Use where.not instead of where

# Rails 6.1+ features (if supporting older versions)
Rails/RedundantPresenceValidationOnBelongsTo:
  Enabled: false              # Only for Rails 5+

# Environment-specific exclusions
Rails/Output:
  Exclude:
    - "db/seeds.rb"           # Allow puts in seeds
    - "lib/tasks/**/*"        # Allow puts in rake tasks
```

### 🏗️ **Rails Architecture Settings**

```yaml
# Controller conventions
Rails/ActionControllerTestCase:
  Enabled: true

# Model conventions  
Rails/ApplicationRecord:
  Enabled: true

Rails/ActiveRecordCallbacksOrder:
  Enabled: true

# Service object patterns (if using)
Style/Documentation:
  Exclude:
    - "app/services/**/*"     # Service objects with clear names

Metrics/ClassLength:
  Exclude:
    - "app/services/**/*"     # Services can be longer

# Background job patterns
Metrics/MethodLength:
  Exclude:
    - "app/jobs/**/*"         # Jobs may have longer perform methods
```

---

## 🧪 Testing Configurations

### 🔬 **RSpec Settings**

```yaml
# RSpec department  
RSpec:
  Enabled: true
  
# Test structure
RSpec/DescribeClass:
  Enabled: true               # Require describe with class
  
RSpec/ContextWording:
  Enabled: true               # Context should start with 'when/with/without'

RSpec/ExampleWording:
  Enabled: true               # Examples should start with verb

# Test length and complexity
RSpec/ExampleLength:
  Max: 20                     # Lines per example
  CountComments: false        # Exclude comments

RSpec/MultipleExpectations:
  Max: 3                      # Expectations per example

RSpec/NestedGroups:
  Max: 4                      # describe/context nesting

# Test organization
RSpec/FilePath:
  Enabled: true               # Spec file location matches class

RSpec/SpecFilePathFormat:
  Enabled: true               # Consistent file naming

# Subject and let usage
RSpec/SubjectStub:
  Enabled: true               # Don't stub subject

RSpec/LetSetup:
  Enabled: true               # Don't use let! for setup

# Shared examples
RSpec/SharedContext:
  Enabled: true               # Proper shared context usage
```

### 🏭 **Factory and Fixture Settings**

```yaml
# Factory-specific rules
RSpec/FactoryBot/CreateList:
  Enabled: true               # Use create_list instead of loop

RSpec/FactoryBot/AttributeDefinedStatically:
  Enabled: true               # Use dynamic attribute definitions

# Factory file exclusions
RSpec/ExampleLength:
  Exclude:
    - "spec/factories/**/*"   # Factories can have long definitions

Metrics/BlockLength:
  Exclude:
    - "spec/factories/**/*"   # Factory blocks can be long
    - "spec/support/**/*"     # Support file configurations

# Feature test allowances
RSpec/MultipleExpectations:
  Exclude:
    - "spec/features/**/*"    # Feature tests may have many expectations
    - "spec/requests/**/*"    # API tests may test multiple attributes
```

### 🧪 **Test-Specific Customizations**

```yaml
# Testing utilities
Lint/Void:
  Exclude:
    - "spec/**/*"             # Allow void expressions in tests

Style/Documentation:
  Exclude:
    - "spec/**/*"             # No documentation required for tests

# Database and external services
Rails/SkipsModelValidations:
  Exclude:
    - "spec/**/*"             # Allow update_attribute in tests
    - "db/seeds.rb"           # Allow in seed files

# Test doubles and mocking
RSpec/MessageSpies:
  EnforcedStyle: receive      # Use receive instead of have_received

RSpec/VerifiedDoubles:
  Enabled: true               # Use instance_double instead of double
```

---

## 🔧 Editor Integration

### 💙 **VS Code Configuration**

Create `.vscode/settings.json`:

```json
{
  "ruby.rubocop.executePath": "bundle exec",
  "ruby.rubocop.configFilePath": ".rubocop.yml",
  "ruby.format": "rubocop",
  "ruby.rubocop.autocorrect": true,
  
  "[ruby]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "rebornix.Ruby",
    "editor.tabSize": 2,
    "editor.insertSpaces": true
  },
  
  "ruby.intellisense": "rubyLocate",
  "ruby.codeCompletion": "rcodetools",
  
  "files.associations": {
    "*.rb": "ruby",
    "Rakefile": "ruby",
    "Gemfile": "ruby",
    "config.ru": "ruby",
    "*.gemspec": "ruby"
  },
  
  "editor.rulers": [80, 120],
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true
}
```

Create `.vscode/tasks.json` for RuboCop tasks:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "RuboCop: Check",
      "type": "shell", 
      "command": "bundle exec rubocop",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always"
      }
    },
    {
      "label": "RuboCop: Auto-correct",
      "type": "shell",
      "command": "bundle exec rubocop --autocorrect",
      "group": "build"
    },
    {
      "label": "RuboCop: Auto-correct All",
      "type": "shell", 
      "command": "bundle exec rubocop --autocorrect-all",
      "group": "build"
    }
  ]
}
```

### 🟣 **Vim/Neovim Configuration**

For `.vimrc` or `init.vim`:

```vim
" RuboCop integration with ALE
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
let g:ale_ruby_rubocop_options = '--config .rubocop.yml'

" Auto-fix on save
let g:ale_fix_on_save = 1

" Custom keybindings
nnoremap <leader>rc :!bundle exec rubocop %<CR>
nnoremap <leader>rca :!bundle exec rubocop --autocorrect %<CR>
nnoremap <leader>rcaa :!bundle exec rubocop --autocorrect-all %<CR>

" Show RuboCop status in statusline
set statusline+=%{ale#statusline#Status()}
```

### 🔵 **RubyMine/IntelliJ Configuration**

1. **Enable RuboCop Integration:**
   - Go to `Settings > Tools > RuboCop`
   - Check "Enable RuboCop"
   - Set RuboCop executable to: `bundle exec rubocop`
   - Set Configuration file to: `.rubocop.yml`

2. **Auto-correction on Save:**
   - Go to `Settings > Tools > File Watchers`
   - Add new watcher for Ruby files
   - Program: `bundle exec rubocop`
   - Arguments: `--autocorrect $FilePath$`

3. **Code Style Settings:**
   - Go to `Settings > Editor > Code Style > Ruby`
   - Import settings from RuboCop configuration

---

## 📈 CI/CD Customizations

### 🔧 **GitHub Actions Advanced Configuration**

`.github/workflows/rubocop.yml`:

```yaml
name: 🔧 RuboCop Quality Check

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  rubocop:
    name: 🔍 RuboCop Analysis
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        ruby-version: ['3.1', '3.2', '3.3']
        
    steps:
    - name: 📥 Checkout
      uses: actions/checkout@v4
      
    - name: 💎 Setup Ruby ${{ matrix.ruby-version }}
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ matrix.ruby-version }}
        bundler-cache: true
        
    - name: 📋 Cache RuboCop
      uses: actions/cache@v3
      with:
        path: ~/.cache/rubocop_cache
        key: rubocop-${{ runner.os }}-${{ matrix.ruby-version }}-${{ hashFiles('.rubocop.yml') }}
        
    - name: 🔍 Run RuboCop
      run: |
        bundle exec rubocop \
          --parallel \
          --format github \
          --format json \
          --out rubocop-results-${{ matrix.ruby-version }}.json
          
    - name: 📊 Upload Results
      uses: actions/upload-artifact@v3
      if: always()
      with:
        name: rubocop-results-${{ matrix.ruby-version }}
        path: rubocop-results-${{ matrix.ruby-version }}.json
        
    # Advanced: Auto-fix and commit changes (for non-main branches)
    - name: 🔧 Auto-fix Issues
      if: github.ref != 'refs/heads/main' && github.event_name == 'pull_request'
      run: |
        bundle exec rubocop --autocorrect-all || true
        
    - name: 📤 Commit Auto-fixes
      if: github.ref != 'refs/heads/main' && github.event_name == 'pull_request'
      uses: stefanzweifel/git-auto-commit-action@v4
      with:
        commit_message: '🔧 Auto-fix RuboCop violations'
        file_pattern: '*.rb'
```

### 🦊 **GitLab CI Advanced Configuration**

`.gitlab-ci.yml`:

```yaml
stages:
  - lint
  - quality-report

variables:
  BUNDLE_PATH: vendor/ruby

🔧 RuboCop:
  stage: lint
  image: ruby:3.3
  cache:
    key: gems-$CI_COMMIT_REF_SLUG
    paths:
      - vendor/ruby
  before_script:
    - bundle config set --local path vendor/ruby
    - bundle install --jobs $(nproc)
  script:
    - bundle exec rubocop --parallel --format json --out rubocop-results.json
  artifacts:
    reports:
      junit: rubocop-results.json
    paths:
      - rubocop-results.json
    expire_in: 1 week
  only:
    - merge_requests
    - main

📊 Quality Report:
  stage: quality-report
  image: ruby:3.3
  dependencies:
    - 🔧 RuboCop
  script:
    - |
      echo "## 📊 RuboCop Quality Report" > quality-report.md
      echo "" >> quality-report.md
      ruby -r json -e "
        data = JSON.parse(File.read('rubocop-results.json'))
        puts \"**Total Files Inspected:** #{data['summary']['inspected_file_count']}\"
        puts \"**Total Offenses:** #{data['summary']['offense_count']}\"
        puts \"**Autocorrectable:** #{data['summary']['correctable_offense_count']}\"
      " >> quality-report.md
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: quality-report.md
```

### 🔄 **Pre-commit Hooks Advanced Setup**

`.pre-commit-config.yaml`:

```yaml
repos:
  - repo: local
    hooks:
      # Run RuboCop with auto-correction first
      - id: rubocop-autocorrect
        name: 🔧 RuboCop Auto-correct
        entry: bundle exec rubocop --autocorrect --fail-level error
        language: system
        files: \.rb$
        pass_filenames: false
        
      # Then run full check
      - id: rubocop-check
        name: 🔍 RuboCop Check  
        entry: bundle exec rubocop --fail-level warning
        language: system
        files: \.rb$
        pass_filenames: true
        
      # Generate updated TODO if violations found
      - id: rubocop-todo
        name: 📋 Update RuboCop TODO
        entry: bash -c 'if ! bundle exec rubocop --fail-level error > /dev/null 2>&1; then bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 100; fi'
        language: system
        files: \.rb$
        pass_filenames: false
        always_run: true

# Additional configuration
default_language_version:
  ruby: system
  
minimum_pre_commit_version: '2.9.0'
```

---

## 🎨 Style Customizations

### ✨ **String and Quote Preferences**

```yaml
# String literal styles
Style/StringLiterals:
  EnforcedStyle: double_quotes     # 'single_quotes' or 'double_quotes'
  ConsistentQuotesInMultiline: true

Style/StringLiteralsInInterpolation:
  EnforcedStyle: double_quotes     # Quotes within interpolation

# Quote preferences
Style/QuotedSymbols:
  EnforcedStyle: same_as_string_literals

# Multi-line string handling
Style/StringConcatenation:
  Mode: aggressive                 # Suggest string interpolation
```

### 🏗️ **Method and Class Structure**

```yaml
# Method definition preferences
Style/DefWithParentheses:
  Enabled: true                    # Always use parentheses

Style/MethodDefParentheses:
  EnforcedStyle: require_parentheses

# Class structure
Layout/ClassStructure:
  Enabled: true
  Categories:
    module_inclusion:
      - include
      - prepend
      - extend
    constants: []
    macros:
      - validates
      - validate
      - scope
    public_class_methods:
      - public_class_method
    initializer:
      - initialize
    public_methods: []
    protected_methods:
      - protected
    private_methods:
      - private

# Access modifier preferences
Style/AccessModifierDeclarations:
  EnforcedStyle: inline           # 'group' or 'inline'
```

### 📊 **Collection and Hash Formatting**

```yaml
# Hash formatting
Style/HashSyntax:
  EnforcedStyle: ruby19           # symbol: vs :symbol =>
  EnforcedShorthandSyntax: always # {a:, b:} vs {a: a, b: b}

Layout/HashAlignment:
  EnforcedHashRocketStyle: table  # Hash rocket alignment
  EnforcedColonStyle: table      # Colon alignment

# Array formatting
Style/ArrayCoercion:
  Enabled: true                   # Use Array() instead of [*var]

Layout/ArrayAlignment:
  EnforcedStyle: with_first_element

# Trailing commas
Style/TrailingCommaInArrayLiteral:
  EnforcedStyleForMultiline: comma

Style/TrailingCommaInHashLiteral:
  EnforcedStyleForMultiline: comma

Style/TrailingCommaInArguments:
  EnforcedStyleForMultiline: comma
```

### 🔄 **Control Flow and Conditionals**

```yaml
# Conditional preferences
Style/ConditionalAssignment:
  EnforcedStyle: assign_to_condition
  SingleLineConditionsOnly: true

Style/TernaryParentheses:
  EnforcedStyle: require_no_parentheses

# Case statement formatting
Layout/CaseIndentation:
  EnforcedStyle: case             # 'case' or 'end'

# Guard clause preferences
Style/GuardClause:
  MinBodyLength: 1
```

---

## 📦 Project Type Templates

### 🚂 **Rails API Project**

```yaml
# .rubocop.yml - Rails API Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.3
  TargetRailsVersion: 7.0
  
  # API-specific exclusions
  Exclude:
    - "app/views/**/*"        # No views in API-only
    - "app/helpers/**/*"      # No view helpers needed
    - "app/assets/**/*"       # No assets in API

# API-focused configurations
Rails/ApplicationController:
  Enabled: true

# JSON response formatting
Layout/MultilineHashBraceLayout:
  EnforcedStyle: new_line

# API security focus
Security/JSONLoad:
  Enabled: true

Lint/JSONLoad:
  Enabled: true

# Serializer patterns (if using)
Metrics/ClassLength:
  Exclude:
    - "app/serializers/**/*"

Style/Documentation:
  Exclude:
    - "app/serializers/**/*"
```

### 📚 **Ruby Gem Project**

```yaml
# .rubocop.yml - Gem Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1      # Support wider versions for gems
  NewCops: enable
  
  Exclude:
    - "spec/fixtures/**/*"
    - "examples/**/*"
    - "vendor/**/*"

# Gem-specific requirements
Style/Documentation:
  Enabled: true               # Important for public gems
  RequireForNonPublicMethods: false

Gemspec/RequiredRubyVersion:
  Enabled: true

Gemspec/DuplicatedAssignment:
  Enabled: true

# Version file handling
Style/FrozenStringLiteralComment:
  Exclude:
    - "lib/**/version.rb"     # Version files often simple

# Testing allowances for gems
Metrics/BlockLength:
  Exclude:
    - "spec/**/*"
    - "test/**/*"
    - "*.gemspec"
    - "Rakefile"

RSpec/FilePath:
  SpecSuffixOnly: true        # Allow flexible spec naming
```

### 🔬 **Microservice Project**

```yaml
# .rubocop.yml - Microservice Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.3
  TargetRailsVersion: 7.0

# Microservice-specific settings
Metrics/ClassLength:
  Max: 100                    # Keep services focused

Metrics/MethodLength:
  Max: 12                     # Short, focused methods

# Service object patterns
Style/Documentation:
  Exclude:
    - "app/services/**/*"     # Service names should be self-documenting
    - "app/jobs/**/*"         # Job names should be clear

# Message handling
Performance/StringReplacement:
  Enabled: true               # Optimize string operations

Performance/RedundantBlockCall:
  Enabled: true               # Optimize block calls

# Container-specific exclusions
AllCops:
  Exclude:
    - "config/environments/container.rb"  # Container-specific configs
    - "docker/**/*"                       # Docker files
```

---

## 🔍 Debugging Configuration

### 🛠️ **Configuration Debugging**

```bash
# Show effective configuration for a file
bundle exec rubocop --show-cops app/models/user.rb

# Display all available cops
bundle exec rubocop --show-cops | grep Style::

# Show configuration inheritance
bundle exec rubocop --debug app/models/user.rb

# Test configuration changes
bundle exec rubocop --config test.rubocop.yml app/
```

### 📊 **Performance Analysis**

```bash
# Profile RuboCop performance
bundle exec rubocop --profile

# Identify slow cops
time bundle exec rubocop --only Style/StringLiterals
time bundle exec rubocop --only Layout/LineLength

# Cache management
ls ~/.cache/rubocop_cache/        # View cache contents
rm -rf ~/.cache/rubocop_cache/    # Clear cache
```

### 🔧 **Configuration Validation**

```yaml
# .rubocop.test.yml - Minimal test configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.3

# Test specific cop configurations
Style/StringLiterals:
  Enabled: true
  EnforcedStyle: double_quotes
```

```bash
# Test with minimal configuration
bundle exec rubocop --config .rubocop.test.yml app/models/user.rb

# Validate configuration syntax
bundle exec rubocop --config .rubocop.yml --show-cops > /dev/null
```

---

## 📚 Additional Resources

### 🔗 **Configuration References**
- **[RuboCop Configuration](https://docs.rubocop.org/rubocop/configuration.html)** - Official configuration guide
- **[Available Cops](https://docs.rubocop.org/rubocop/cops.html)** - Complete cop reference
- **[Rails Cops](https://docs.rubocop.org/rubocop-rails/)** - Rails-specific cop documentation

### 🛠️ **Tools & Utilities**
- **[RuboCop Configuration Generator](https://rubocop.org/config_generator/)** - Online configuration builder
- **[Cop Comparison Tool](https://rubocop.org/cop_comparison/)** - Compare cop configurations
- **[Performance Analyzer](https://rubocop.org/performance/)** - Analyze RuboCop performance

### 💬 **Community Resources**
- **[GitHub Discussions](https://github.com/hammadxcm/rubocop-hk/discussions)** - Ask configuration questions
- **[Example Configurations](https://github.com/hammadxcm/rubocop-hk/wiki/Example-Configurations)** - Real-world examples
- **[Team Setup Guide](https://github.com/hammadxcm/rubocop-hk/wiki/Team-Setup)** - Team adoption strategies

---

<div align="center">

## 🎯 Perfect Your Configuration

**Now you have the power to customize RuboCop HK for any project!**

[![Quick Start](https://img.shields.io/badge/⚡_Quick-Start-green.svg)](QUICK_START.md)
[![Usage Guide](https://img.shields.io/badge/📖_Usage-Guide-blue.svg)](USAGE.md)
[![Back to README](https://img.shields.io/badge/🏠_Back_to-README-purple.svg)](README.md)

**Questions about configuration? [Open a discussion](https://github.com/hammadxcm/rubocop-hk/discussions) and we'll help!**

</div>