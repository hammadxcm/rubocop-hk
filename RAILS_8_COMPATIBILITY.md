# 🚀 Rails 8 Compatibility Guide

> **Status**: ✅ **Fully Compatible** - Rails 8.0.2+ officially supported

## 📋 Overview

RuboCop HK provides comprehensive support for Rails 8.0+ including integration with Rails 8's new "Omakase RuboCop" features and modern authentication patterns.

## 🆕 Rails 8 Features Supported

### ✅ **Omakase RuboCop Integration**
Rails 8 includes an Omakase RuboCop configuration by default. RuboCop HK works seamlessly alongside or as a replacement for Rails 8's built-in configuration.

```ruby
# config/application.rb - Rails 8 integration
class Application < Rails::Application
  # Rails 8 Omakase RuboCop is automatically included
  # RuboCop HK enhances this with additional rules
  config.load_defaults 8.0
  
  # Enhanced generator configuration
  config.generators do |g|
    g.test_framework :rspec
    g.system_tests :capybara
    g.assets false
    g.helper false
    g.stylesheets false
  end
end
```

### ✅ **Modern Authentication Patterns**
```ruby
# Rails 8 authentication with RuboCop HK validation
class SessionsController < ApplicationController
  # Rails 8 authenticate_by pattern - fully supported
  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    
    if user
      session[:user_id] = user.id
      render json: { status: "success" }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end
```

### ✅ **Solid Cache Integration**
```ruby
# Rails 8 Solid Cache patterns - RuboCop HK compatible
class ProductsController < ApplicationController
  def index
    @products = Rails.cache.fetch("products/recent", expires_in: 1.hour) do
      Product.includes(:category)
             .where(active: true)
             .order(created_at: :desc)
             .limit(50)
    end
    
    render json: @products, status: :ok
  end
end
```

## 🔧 Installation with Rails 8

### **New Rails 8 Application**
```bash
# Create Rails 8 app
rails new my_app --css=tailwind --database=postgresql

# Add RuboCop HK
bundle add rubocop-hk -v "~> 1.0.0" --group development,test

# Create configuration
cat << 'EOF' > .rubocop.yml
inherit_gem:
  rubocop-hk: config/default.yml

AllCops:
  TargetRubyVersion: 3.1
  TargetRailsVersion: 8.0
  NewCops: enable

Rails:
  Enabled: true
EOF

# Run RuboCop
bundle exec rubocop --autocorrect-all
```

### **Existing Rails 8 Upgrade**
```bash
# If upgrading from Rails 7.x to 8.0
bundle update rails

# Update RuboCop HK configuration
cat << 'EOF' >> .rubocop.yml
AllCops:
  TargetRailsVersion: 8.0  # Update from 7.x
EOF

# Test compatibility
bundle exec rubocop --autocorrect-all --safe
```

## 🆚 Rails 8 Omakase vs RuboCop HK

| Feature | Rails 8 Omakase | RuboCop HK | Recommendation |
|---------|----------------|------------|----------------|
| **Basic Rules** | ✅ Included | ✅ Enhanced | Use both together |
| **Performance Cops** | ❌ Limited | ✅ Comprehensive | RuboCop HK required |
| **Rails-Specific** | ✅ Basic | ✅ Advanced | RuboCop HK enhanced |
| **Team Customization** | ❌ Rigid | ✅ Flexible | RuboCop HK for teams |
| **CI Integration** | ✅ GitHub Actions | ✅ All platforms | RuboCop HK versatile |

### **Recommended Setup: Both Together**
```yaml
# .rubocop.yml - Best of both worlds
inherit_from:
  - .rubocop_rails_omakase.yml  # Rails 8 defaults
  
inherit_gem:
  rubocop-hk: config/default.yml  # Enhanced rules

AllCops:
  TargetRubyVersion: 3.1
  TargetRailsVersion: 8.0
  NewCops: enable

# Override any conflicts in favor of team preferences
Style/StringLiterals:
  EnforcedStyle: double_quotes  # RuboCop HK preference
```

## 🚀 Rails 8 Enhanced Features

### **Kamal Deployment Compatibility**
```yaml
# config/deploy.yml - Kamal deployment with RuboCop HK
image: my-rails-app

servers:
  - 192.168.1.10

# RuboCop HK checks during deployment
pre_deploy:
  - bundle exec rubocop --fail-level error
  - bundle exec rspec
```

### **Enhanced Developer Experience**
```ruby
# Rails 8 LSP integration works perfectly with RuboCop HK
# config/development.rb
Rails.application.configure do
  # Enhanced developer tools
  config.enable_reloading = true
  
  # RuboCop HK integrates with Rails 8 LSP
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
```

## 📊 Compatibility Matrix

| Rails Version | RuboCop HK Status | Notes |
|---------------|-------------------|-------|
| **Rails 8.0+** | ✅ **Fully Supported** | Enhanced integration with Omakase |
| **Rails 7.1** | ✅ **Supported** | All features available |
| **Rails 7.0** | ✅ **Supported** | Stable production choice |
| **Rails 6.1** | ✅ **Supported** | Legacy support maintained |
| **Rails 6.0** | ⚠️ **Limited** | Upgrade recommended |

## 🔍 Testing Rails 8 Compatibility

```ruby
# spec/rails_helper.rb - Rails 8 with RSpec
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Rails 8 system test configuration
RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  
  # Rails 8 enhanced testing features
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ActionCable::TestHelper
end
```

## ⚡ Performance with Rails 8

Rails 8 + RuboCop HK performance optimizations:

```bash
# Optimized for Rails 8 large applications
export RUBOCOP_OPTS="--parallel --cache"
bundle exec rubocop $RUBOCOP_OPTS

# Use Rails 8 zeitwerk for faster loading
export RAILS_ENV=development
bundle exec rubocop --only Performance/
```

## 🎯 Migration Path

### **From Rails 7.x to Rails 8**
1. **Update Rails**: `bundle update rails`
2. **Update RuboCop HK config**: Set `TargetRailsVersion: 8.0`
3. **Run auto-correction**: `bundle exec rubocop --autocorrect-all`
4. **Review new Rails 8 patterns**: Update authentication, caching, etc.
5. **Test thoroughly**: Ensure all RuboCop rules pass

### **From Standard RuboCop to RuboCop HK + Rails 8**
1. **Install RuboCop HK**: `bundle add rubocop-hk -v "~> 1.0.0"`
2. **Update configuration**: Use `inherit_gem: rubocop-hk`
3. **Maintain Rails 8 Omakase**: Keep `.rubocop_rails_omakase.yml`
4. **Merge configurations**: Best of both worlds approach

---

## 🏆 **Conclusion**

RuboCop HK provides **full Rails 8 compatibility** with enhanced features beyond Rails 8's built-in Omakase configuration. The gem works seamlessly with Rails 8's new patterns while providing additional performance, security, and team collaboration features.

**Recommendation**: Use RuboCop HK alongside Rails 8's Omakase configuration for the best developer experience and code quality enforcement.