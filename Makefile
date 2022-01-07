.PHONY: restart
restart: stop start

.PHONY: api
api:
	poetry export --dev -o ./requirements.txt

.PHONY: start
start: api
	docker compose up -d --build

.PHONY: stop
stop:
	docker compose down -v

.PHONY: test
test:
	docker compose exec api python -m pytest