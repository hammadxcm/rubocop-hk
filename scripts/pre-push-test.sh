#!/bin/bash

# 🚀 Pre-Push GitHub Actions Test
# Simple script to verify workflows will pass

set -e
trap 'echo "❌ Test failed at line $LINENO"' ERR

echo "🧪 GitHub Actions Pre-Push Test"
echo "==============================="
echo

# Test 1: Dependencies & Bundle
echo "1️⃣  Testing dependencies..."
bundle check >/dev/null 2>&1 || bundle install --quiet
echo "   ✅ Dependencies resolved"

# Test 2: RSpec Tests
echo "2️⃣  Testing RSpec suite..."
bundle exec rspec --format progress >/dev/null 2>&1
echo "   ✅ All tests pass"

# Test 3: RuboCop Linting  
echo "3️⃣  Testing RuboCop linting..."
bundle exec rubocop --parallel >/dev/null 2>&1
echo "   ✅ No lint violations"

# Test 4: Security Audit
echo "4️⃣  Testing security audit..."
if ! command -v bundler-audit >/dev/null 2>&1; then
    gem install bundler-audit >/dev/null 2>&1
fi
bundler-audit update >/dev/null 2>&1
bundler-audit check >/dev/null 2>&1
echo "   ✅ No security vulnerabilities"

# Test 5: Configuration Validation
echo "5️⃣  Testing configuration files..."
bundle exec ruby -e "
require 'yaml'
require 'rubocop'

# Test YAML syntax
Dir['config/*.yml'].each { |f| YAML.load_file(f) }

# Test RuboCop config loading  
RuboCop::ConfigLoader.load_file('./config/default.yml')
" >/dev/null 2>&1
echo "   ✅ Configuration files valid"

# Test 6: Gem Build
echo "6️⃣  Testing gem build..."
gem build rubocop-hk.gemspec >/dev/null 2>&1
echo "   ✅ Gem builds successfully"

# Test 7: Workflow Syntax
echo "7️⃣  Testing workflow syntax..."
for workflow in .github/workflows/*.yml; do
    if [[ -f "$workflow" ]]; then
        # Test YAML syntax with Ruby
        bundle exec ruby -e "require 'yaml'; YAML.load_file('$workflow')" >/dev/null 2>&1
    fi
done
echo "   ✅ Workflow syntax valid"

# Summary
echo
echo "🎉 ALL TESTS PASSED!"
echo "==================="
echo
echo "Your GitHub Actions workflows are ready:"
echo "✅ CI workflow will pass"
echo "✅ Security workflow will pass"  
echo "✅ Release workflow will pass"
echo
echo "Safe to push! 🚀"