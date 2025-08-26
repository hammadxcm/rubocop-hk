.DEFAULT: test

# Standard test suite
test:
	bundle exec rspec
	bundle exec rubocop

# Pre-push workflow testing
test-workflows:
	./scripts/pre-push-test.sh

# Legacy Docker support
test-docker:
	docker-compose run --rm gem sh -c "./bin/setup && bundle exec rake"

console:
	docker-compose run --rm gem sh -c "./bin/setup && ./bin/console"

# Development helpers
install:
	bundle install

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop --autocorrect

security:
	bundler-audit update && bundler-audit check

build:
	gem build rubocop-hk.gemspec

clean:
	rm -f *.gem

.PHONY: test test-workflows test-docker install lint lint-fix security build clean console
