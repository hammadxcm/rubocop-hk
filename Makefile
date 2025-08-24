.DEFAULT: test

test:
	docker-compose run --rm gem sh -c "./bin/setup && bundle exec rake"

console:
	docker-compose run --rm gem sh -c "./bin/setup && ./bin/console"
