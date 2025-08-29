# ⚡ Quick Start Guide - RuboCop HK

> **Get up and running with RuboCop HK in under 5 minutes!**  
> **🆕 v1.2.1: Now with 45+ warning-only modern rules for Ruby 3.3 & Rails 8.0**

<div align="center">

[![Gem Version](https://badge.fury.io/rb/rubocop-hk.svg)](https://badge.fury.io/rb/rubocop-hk)
[![Ruby](https://img.shields.io/badge/ruby-3.3+-red.svg)](https://www.ruby-lang.org)
[![Rails](https://img.shields.io/badge/rails-8.0+-red.svg)](https://rubyonrails.org)

**[📚 Full Documentation](README.md) • [📖 Usage Examples](USAGE.md) • [⚙️ Customization](CUSTOMIZATION.md)**

</div>

---

## 🎯 Choose Your Path

<table>
<tr>
<td align="center" width="33%">

### 🆕 **New Project**
<br>
Starting fresh?<br>
Perfect! 

**[👇 Jump to New Setup](#-new-project-setup)**

</td>
<td align="center" width="33%">

### 🔄 **Existing Project** 
<br>
Have existing code?<br>
We've got you covered!

**[👇 Jump to Migration](#-existing-project-migration)**

</td>
<td align="center" width="33%">

### 💎 **Gem Development**
<br>
Building a Ruby gem?<br>
Special considerations!

**[👇 Jump to Gem Setup](#-gem-development-setup)**

</td>
</tr>
</table>

---

## 🆕 New Project Setup

### 🚂 **Rails Application (Recommended)**

Copy and paste these commands in your terminal:

```bash
# ✨ One-command setup for Rails
curl -sSL https://raw.githubusercontent.com/hammadxcm/rubocop-hk/main/scripts/rails-setup.sh | bash
```

Or manually:

<details>
<summary><strong>📋 Manual Rails Setup</strong></summary>

```bash
# 1️⃣ Add RuboCop HK to your Gemfile
cat << 'EOF' >> Gemfile

# 🔧 Code quality and style enforcement  
group :development, :test do
  gem "rubocop-hk", "~> 1.0.9", require: false
end
EOF

# 2️⃣ Install the gem
bundle install

# 3️⃣ Create optimized Rails configuration
cat << 'EOF' > .rubocop.yml
# 🚂 RuboCop HK - Rails Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2      # 🎯 Your Ruby version
  TargetRailsVersion: 7.0     # 🚂 Your Rails version  
  NewCops: enable             # ✨ Get latest improvements

  # 📁 Skip Rails-generated files
  Exclude:
    - "db/schema.rb"
    - "db/migrate/*.rb"
    - "bin/**/*"
    - "config/boot.rb"
    - "config/environment.rb"
    - "node_modules/**/*"
EOF

# 4️⃣ Run initial cleanup
bundle exec rubocop --autocorrect-all

# 5️⃣ Set up Rails generator integration (Rails 7.2+)
cat << 'EOF' >> config/environments/development.rb

  # 🔧 Auto-format generated code
  config.generators.apply_rubocop_autocorrect_after_generate! if Rails.env.development?
EOF

echo "🎉 RuboCop HK setup complete!"
```

</details>

### 💎 **Ruby-Only Project**

```bash
# 1️⃣ Install RuboCop HK
gem install rubocop-hk -v "~> 1.0.0"

# 2️⃣ Create configuration
cat << 'EOF' > .rubocop.yml
# 💎 RuboCop HK - Ruby Configuration  
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.2      # 🎯 Your Ruby version
  NewCops: enable
EOF

# 3️⃣ Check your code
rubocop --autocorrect-all

echo "✅ RuboCop HK ready for Ruby development!"
```

---

## 🔄 Existing Project Migration

### 📦 **Safe Migration (Recommended)**

Perfect for legacy codebases with existing code:

```bash
# 🛡️ Backup existing configuration
[ -f .rubocop.yml ] && cp .rubocop.yml .rubocop.yml.backup

# 📦 Add RuboCop HK to existing project
bundle add rubocop-hk --group development,test --require false

# 🎯 Create migration-friendly configuration
cat << 'EOF' > .rubocop.yml
# 🔄 RuboCop HK - Migration Configuration
inherit_gem:
  rubocop-hk: config/default.yml

# 📋 Start with TODO file for gradual adoption  
inherit_from: .rubocop_todo.yml

AllCops:
  TargetRubyVersion: 3.1      # 🎯 Adjust to your current version
  TargetRailsVersion: 7.0     # 🚂 Adjust to your Rails version
  NewCops: disable            # 🚫 Don't enable new cops yet
  
  # 📁 Exclude problematic areas initially
  Exclude:
    - "db/**/*"
    - "config/**/*"  
    - "vendor/**/*"
    - "node_modules/**/*"
EOF

# 📊 Generate TODO list for existing violations
bundle exec rubocop --auto-gen-config --auto-gen-only-exclude --exclude-limit 10000

# ✅ Apply safe auto-corrections only
bundle exec rubocop --autocorrect --safe

echo "🎯 Migration setup complete! Check .rubocop_todo.yml for improvement plan."
```

### 📈 **Gradual Improvement Plan**

After initial setup, improve your code quality over time:

<details>
<summary><strong>📅 4-Week Improvement Schedule</strong></summary>

**Week 1: Layout & Simple Fixes**
```bash
# Focus on safe, automatic improvements
bundle exec rubocop --only Layout --autocorrect
bundle exec rubocop --only Style/TrailingWhitespace --autocorrect
bundle exec rubocop --only Style/EmptyLines --autocorrect
```

**Week 2: String & Hash Consistency**  
```bash
# Standardize string literals and hash syntax
bundle exec rubocop --only Style/StringLiterals --autocorrect
bundle exec rubocop --only Style/HashSyntax --autocorrect
bundle exec rubocop --only Style/TrailingCommaInHashLiteral --autocorrect
```

**Week 3: Method & Class Structure**
```bash
# Improve method definitions and class structure
bundle exec rubocop --only Style/DefWithParentheses --autocorrect
bundle exec rubocop --only Layout/ClassStructure --autocorrect
bundle exec rubocop --only Style/EmptyMethod --autocorrect
```

**Week 4: Rails Best Practices**
```bash
# Apply Rails-specific improvements
bundle exec rubocop --only Rails --autocorrect
bundle exec rubocop --only Performance --autocorrect
```

</details>

---

## 💎 Gem Development Setup

### 📚 **Ruby Gem Project**

Special configuration for open-source gems:

```bash
# 1️⃣ Add to gemspec development dependencies
cat << 'EOF' >> your_gem.gemspec

  # 🔧 Development dependencies
  spec.add_development_dependency "rubocop-hk", "~> 1.0.0"
EOF

# 2️⃣ Create gem-optimized configuration  
cat << 'EOF' > .rubocop.yml
# 💎 RuboCop HK - Gem Configuration
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1      # 🎯 Support wider Ruby versions
  NewCops: enable

# 📖 Documentation is crucial for gems
Style/Documentation:
  Enabled: true
  RequireForNonPublicMethods: false

# 🧪 Relax rules for test files  
Metrics/BlockLength:
  Exclude:
    - "spec/**/*"
    - "test/**/*"
    - "*.gemspec"
    - "Rakefile"

# 📦 Gem-specific exclusions
AllCops:
  Exclude:
    - "vendor/**/*"
    - "spec/fixtures/**/*"
EOF

# 3️⃣ Setup development environment
bundle install
bundle exec rubocop --autocorrect-all

echo "💎 Gem development setup complete!"
```

---

## 🔧 Essential Commands

### ⚡ **Daily Development**

```bash
# 🔍 Check your code  
bundle exec rubocop

# ✅ Auto-fix safe issues
bundle exec rubocop --autocorrect

# 🚀 Fix everything (be careful!)
bundle exec rubocop --autocorrect-all

# 📊 Show progress  
bundle exec rubocop --format progress
```

### 🎯 **Targeted Checks**

```bash
# 📁 Check specific files/directories
bundle exec rubocop app/models/
bundle exec rubocop app/models/user.rb

# 🎪 Check specific cop categories
bundle exec rubocop --only Style
bundle exec rubocop --only Layout
bundle exec rubocop --only Rails

# 🎯 Check specific cops
bundle exec rubocop --only Style/StringLiterals
```

### 📋 **Reporting & Analysis**

```bash
# 📊 Generate HTML report
bundle exec rubocop --format html --out rubocop-report.html

# 📈 JSON output for CI/tooling
bundle exec rubocop --format json --out rubocop-results.json

# 📋 List all available cops
bundle exec rubocop --show-cops
```

---

## 🔧 Editor Integration

### 💙 **VS Code (Recommended)**

<details>
<summary><strong>⚙️ One-Click VS Code Setup</strong></summary>

```bash
# 🔧 Install Ruby extension
code --install-extension rebornix.Ruby

# ⚙️ Create VS Code settings
mkdir -p .vscode
cat << 'EOF' > .vscode/settings.json
{
  "ruby.rubocop.executePath": "bundle exec",
  "ruby.rubocop.configFilePath": ".rubocop.yml", 
  "ruby.format": "rubocop",
  "[ruby]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "rebornix.Ruby"
  },
  "ruby.rubocop.autocorrect": true
}
EOF

# ⌨️ Add keyboard shortcuts  
cat << 'EOF' > .vscode/keybindings.json
[
  {
    "key": "ctrl+alt+f",
    "command": "ruby.rubocop.autocorrect", 
    "when": "editorLangId == ruby"
  }
]
EOF

echo "💙 VS Code integration ready!"
```

</details>

### 🟣 **Other Editors**

<details>
<summary><strong>Vim/Neovim with ALE</strong></summary>

```vim
" Add to your .vimrc or init.vim
Plug 'dense-analysis/ale'

let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
let g:ale_ruby_rubocop_options = '--autocorrect'
let g:ale_fixers = {'ruby': ['rubocop']}
let g:ale_fix_on_save = 1
```

</details>

<details>
<summary><strong>Sublime Text</strong></summary>

1. Install Package Control
2. Install SublimeLinter and SublimeLinter-rubocop
3. Configure in `Preferences > Package Settings > SublimeLinter > Settings`:

```json
{
  "linters": {
    "rubocop": {
      "executable": ["bundle", "exec", "rubocop"]
    }
  }
}
```

</details>

---

## 🚨 Troubleshooting

### ❌ **Common Issues**

<details>
<summary><strong>"Configuration file not found"</strong></summary>

**Problem:** 
```
Configuration file not found: config/default.yml
```

**Solution:**
```bash
# Check if gem is installed
bundle list | grep rubocop-hk

# Verify .rubocop.yml syntax (no quotes around config path!)
inherit_gem:
  rubocop-hk: config/default.yml  # ✅ Correct
  # rubocop-hk: "config/default.yml"  # ❌ Wrong
```

</details>

<details>
<summary><strong>"Too many violations"</strong></summary>

**Problem:**
```
1847 offenses detected
```

**Solution:**
```bash
# Generate TODO file for gradual improvement
bundle exec rubocop --auto-gen-config

# Add to your .rubocop.yml
echo "inherit_from: .rubocop_todo.yml" >> .rubocop.yml

# Fix issues gradually
bundle exec rubocop --autocorrect --safe
```

</details>

<details>
<summary><strong>"RuboCop running slowly"</strong></summary>

**Solution:**
```bash
# Use parallel processing and caching
bundle exec rubocop --parallel --cache

# Exclude large files
echo "AllCops:
  Exclude:
    - 'db/schema.rb'
    - 'vendor/**/*'" >> .rubocop.yml
```

</details>

---

## 📈 Next Steps

### 🎯 **Now That You're Set Up**

1. **📖 Read the [Usage Guide](USAGE.md)** - Comprehensive examples and scenarios
2. **⚙️ Check [Customization Options](CUSTOMIZATION.md)** - Tailor RuboCop to your team
3. **🎨 Review the [Style Guide](STYLEGUIDE.md)** - Understand the coding standards
4. **🔄 Set up CI/CD** - Automate code quality checks

### 🤝 **Join the Community**

- **[⭐ Star the repo](https://github.com/hammadxcm/rubocop-hk)** if RuboCop HK helps you!
- **[🐛 Report issues](https://github.com/hammadxcm/rubocop-hk/issues)** you encounter
- **[💬 Join discussions](https://github.com/hammadxcm/rubocop-hk/discussions)** with other users
- **[🤝 Contribute improvements](CONTRIBUTING.md)** to make it even better

---

## 💡 Pro Tips

<details>
<summary><strong>🚀 Speed Up Your Workflow</strong></summary>

```bash
# Create aliases for common commands
echo 'alias cop="bundle exec rubocop"
alias copa="bundle exec rubocop --autocorrect"
alias copaa="bundle exec rubocop --autocorrect-all"' >> ~/.bashrc

# Use these shortcuts:
cop          # Check code
copa         # Safe auto-fix
copaa        # Fix everything
```

</details>

<details>
<summary><strong>🎯 Focus Your Reviews</strong></summary>

```bash
# Check only files changed in current branch
git diff --name-only main | grep '\.rb$' | xargs bundle exec rubocop

# Check staged files before commit
git diff --cached --name-only | grep '\.rb$' | xargs bundle exec rubocop
```

</details>

<details>
<summary><strong>📊 Track Your Progress</strong></summary>

```bash
# Count violations over time
echo "$(date): $(bundle exec rubocop --format offenses | tail -1)" >> rubocop-progress.txt

# See your improvement!
cat rubocop-progress.txt
```

</details>

---

<div align="center">

## 🎉 You're Ready to Go!

**RuboCop HK is now protecting your code quality** 

[![Usage Examples](https://img.shields.io/badge/📖_Read-Usage_Examples-blue.svg)](USAGE.md)
[![Customization](https://img.shields.io/badge/⚙️_Explore-Customization-green.svg)](CUSTOMIZATION.md)
[![Back to README](https://img.shields.io/badge/🏠_Back_to-README-purple.svg)](README.md)

**Questions? Check our [FAQ](README.md#-faq--troubleshooting) or [open an issue](https://github.com/hammadxcm/rubocop-hk/issues)!**

</div>