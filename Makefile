# RuboCop HK - Enhanced Makefile with Modern Rules Support
# Modern development workflow with warning management

.DEFAULT: help

# Help target
help:
	@echo "🚀 RuboCop HK Development Commands"
	@echo ""
	@echo "📋 Basic Commands:"
	@echo "  make test               - Run all tests"
	@echo "  make lint               - Run RuboCop linting"
	@echo "  make lint-auto-correct  - Auto-fix correctable issues"
	@echo "  make install            - Install gem dependencies"
	@echo ""
	@echo "⚠️  Warning Management:"
	@echo "  make check-warnings     - Show all current warnings"
	@echo "  make warning-summary    - Count warnings by type"
	@echo "  make promote COPS='Style/FetchEnvVar Rails/EnumSyntax' - Promote warnings to errors"
	@echo ""
	@echo "🔧 Development:"
	@echo "  make setup             - Full development setup"
	@echo "  make build             - Build gem"
	@echo "  make clean             - Clean build artifacts"

# Test commands
test:
	@echo "🧪 Running test suite..."
	bundle exec rspec
	bundle exec rubocop --config config/default.yml

test-coverage:
	@echo "📊 Running tests with coverage..."
	COVERAGE=true bundle exec rspec

# Pre-push workflow testing (legacy)
test-workflows:
	./scripts/pre-push-test.sh

# Legacy Docker support
test-docker:
	docker-compose run --rm gem sh -c "./bin/setup && bundle exec rake"

console:
	docker-compose run --rm gem sh -c "./bin/setup && ./bin/console"

# Linting commands
lint:
	@echo "🔍 Running RuboCop..."
	bundle exec rubocop --config config/default.yml

lint-auto-correct:
	@echo "🛠️  Auto-correcting RuboCop issues..."
	bundle exec rubocop --config config/default.yml --auto-correct

lint-safe-auto-correct:
	@echo "🛡️  Auto-correcting safe RuboCop issues only..."
	bundle exec rubocop --config config/default.yml --safe-auto-correct

# Warning management
check-warnings:
	@echo "⚠️  Current RuboCop warnings:"
	@bundle exec rubocop --config config/default.yml --format simple | grep -E "warning|W:" || echo "No warnings found! 🎉"

warning-summary:
	@echo "📊 Warning summary by cop:"
	@bundle exec rubocop --config config/default.yml --format json | jq -r '.files[].offenses[] | select(.severity == "warning") | .cop_name' | sort | uniq -c | sort -nr || echo "Install jq for detailed summary"

warning-count:
	@echo "📈 Total warnings:"
	@bundle exec rubocop --config config/default.yml --format json | jq '.summary.offense_count' || bundle exec rubocop --config config/default.yml --format simple | grep -c "warning" || echo "0"

# Priority warnings (Rails 8.0 critical)
check-rails8-warnings:
	@echo "🚨 Rails 8.0 compatibility warnings:"
	@bundle exec rubocop --config config/default.yml --only Rails/EnumSyntax,Rails/DeprecatedActiveModelErrorsMethods --format simple || echo "No Rails 8.0 warnings! 🎉"

# Promotion command
promote:
ifdef COPS
	@echo "🚀 Promoting cops: $(COPS)"
	ruby scripts/promote-warnings.rb $(COPS)
else
	@echo "❌ Usage: make promote COPS='Style/FetchEnvVar Rails/EnumSyntax'"
	@echo "📋 Available warning cops:"
	@ruby scripts/promote-warnings.rb
endif

# Auto-fix easy wins
fix-easy-wins:
	@echo "🎯 Auto-fixing easy modernization wins..."
	bundle exec rubocop --config config/default.yml --auto-correct --only Style/CollectionCompact,Style/StringChars,Style/RedundantArgument,Performance/Sum

# Development setup
setup: install
	@echo "🛠️  Setting up development environment..."
	@echo "✅ Development setup complete!"
	@echo ""
	@echo "📚 Next steps:"
	@echo "  1. Read GRADUAL_ADOPTION_GUIDE.md for team guidance"
	@echo "  2. Review MODERN_RULES_REFERENCE.md for rule explanations"
	@echo "  3. Run 'make check-warnings' to see current warnings"

install:
	@echo "📦 Installing dependencies..."
	bundle install

# Legacy alias
lint-fix: lint-auto-correct

# Security check
security:
	bundler-audit update && bundler-audit check

# Build commands  
build:
	@echo "🏗️  Building gem..."
	gem build rubocop-hk.gemspec

clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -f *.gem
	rm -rf coverage/
	rm -rf tmp/

# Quick development workflow
dev-check: test lint check-warnings
	@echo "✅ Development check complete!"

# Show configuration info
config-info:
	@echo "📋 Current RuboCop configuration:"
	@echo "Ruby version target: $$(grep TargetRubyVersion config/default.yml | awk '{print $$2}')"
	@echo "Rails version target: $$(grep TargetRailsVersion config/default.yml | awk '{print $$2}')"
	@echo "Total configuration files: $$(find config/ -name '*.yml' | wc -l)"

.PHONY: help test test-coverage test-workflows test-docker console lint lint-auto-correct lint-safe-auto-correct check-warnings warning-summary warning-count check-rails8-warnings promote fix-easy-wins setup install lint-fix security build clean dev-check config-info
