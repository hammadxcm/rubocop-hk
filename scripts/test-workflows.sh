#!/bin/bash

# 🧪 GitHub Actions Workflow Testing Script
# Run this before pushing to ensure workflows will pass

set -e  # Exit on any error

echo "🚀 GitHub Actions Workflow Testing"
echo "=================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}🔍 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Test 1: Environment Check
print_step "Testing environment setup..."
echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundle -v)"
echo "Git status: $(git status --porcelain | wc -l | tr -d ' ') uncommitted changes"
print_success "Environment ready"
echo ""

# Test 2: Dependencies
print_step "Testing dependency installation..."
bundle install --quiet
bundle check --quiet
print_success "Dependencies installed and verified"
echo ""

# Test 3: Lint (CI workflow - lint job)
print_step "Testing RuboCop linting (CI: lint job)..."
if bundle exec rubocop --parallel --format progress; then
    print_success "RuboCop linting passed"
else
    print_error "RuboCop linting failed - fix violations before pushing"
    exit 1
fi
echo ""

# Test 4: Tests (CI workflow - test job)
print_step "Testing RSpec suite (CI: test job)..."
if bundle exec rspec --format progress; then
    print_success "All tests passed ($(bundle exec rspec --format progress 2>&1 | grep -o '[0-9]* examples' | head -1))"
else
    print_error "Tests failed - fix failing tests before pushing"
    exit 1
fi
echo ""

# Test 5: Configuration Validation (CI workflow - test job)
print_step "Testing configuration validation (CI: test job)..."
bundle exec ruby -e "
require 'yaml'
require 'rubocop'

puts '  🔍 Validating YAML syntax...'
Dir['config/*.yml'].each do |file|
  begin
    YAML.load_file(file)
    puts \"    ✅ #{file}\"
  rescue => e
    puts \"    ❌ #{file}: #{e.message}\"
    exit 1
  end
end

puts '  🔍 Validating RuboCop configuration loading...'
begin
  RuboCop::ConfigLoader.load_file('./config/default.yml')
  puts '    ✅ Configuration loads successfully'
rescue => e
  puts \"    ❌ Configuration failed: #{e.message}\"
  exit 1
end
"
print_success "Configuration validation passed"
echo ""

# Test 6: Security Audit (Security workflow)
print_step "Testing security audit (Security workflow)..."

# Install bundler-audit if not present
if ! command -v bundler-audit &> /dev/null; then
    echo "  📦 Installing bundler-audit..."
    gem install bundler-audit --silent
fi

echo "  🔍 Updating security database..."
bundler-audit update --quiet

echo "  🔍 Running vulnerability scan..."
if bundler-audit check; then
    print_success "No security vulnerabilities found"
else
    print_error "Security vulnerabilities detected - update dependencies"
    exit 1
fi

echo "  🔍 Running RuboCop security checks..."
if bundle exec rubocop --only Security --format simple; then
    print_success "Security cops passed"
else
    print_error "Security violations found"
    exit 1
fi

echo "  🔍 Checking for hardcoded secrets..."
if grep -r -E "(password|secret|key|token)\s*=\s*['\"][^'\"]{8,}" . --exclude-dir=.git --exclude-dir=node_modules --exclude="*.md" --exclude="test-workflows.sh" > /dev/null; then
    print_error "Potential secrets found in code"
    exit 1
else
    print_success "No obvious secrets detected"
fi
echo ""

# Test 7: Build Test (Release workflow)
print_step "Testing gem build (Release workflow)..."
if gem build rubocop-hk.gemspec > /dev/null 2>&1; then
    GEM_FILE=$(ls -t rubocop-hk-*.gem | head -1)
    print_success "Gem built successfully: $GEM_FILE"
    
    # Test gem installation in a clean environment
    echo "  🔍 Testing gem installation..."
    if gem install ./$GEM_FILE --silent; then
        print_success "Gem installs successfully"
        
        echo "  🔍 Testing gem functionality..."
        if ruby -e "require 'rubocop/hk'; puts Rubocop::Hk::VERSION" > /dev/null; then
            print_success "Gem functions correctly"
        else
            print_error "Gem functionality test failed"
            exit 1
        fi
    else
        print_error "Gem installation failed"
        exit 1
    fi
else
    print_error "Gem build failed"
    exit 1
fi
echo ""

# Test 8: Workflow Syntax Validation
print_step "Validating GitHub Actions workflow syntax..."
for workflow_file in .github/workflows/*.yml; do
    if [ -f "$workflow_file" ]; then
        echo "  🔍 Validating $(basename $workflow_file)..."
        if python3 -c "import yaml; yaml.safe_load(open('$workflow_file'))" 2>/dev/null; then
            echo "    ✅ $(basename $workflow_file) - Valid YAML"
        else
            print_error "$(basename $workflow_file) - Invalid YAML syntax"
            exit 1
        fi
    fi
done
print_success "All workflow files have valid syntax"
echo ""

# Summary
echo "🎉 ALL TESTS PASSED!"
echo "==================="
echo ""
echo "Your workflows are ready for GitHub Actions:"
echo "✅ CI workflow (lint, test, build)"  
echo "✅ Security workflow (audit, scan)"
echo "✅ Release workflow (build, publish)"
echo ""
echo "Safe to push! 🚀"