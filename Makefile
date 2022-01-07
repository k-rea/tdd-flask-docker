.PHONY: test
test:
	docker compose exec api python -m pytest "src/tests" -p no:warnings --cov="src" --cov-report html

.PHONY: dc
dc: restart

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


.PHONY: cov
cov:
	open htmlcov/index.html

.PHONY: flake8
flake8:
	docker compose exec api flake8 src

.PHONY: black
black:
	docker compose exec api black src

.PHONY: check
check:
	docker compose exec api flake8 src
	docker compose exec api black src --check
	docker compose exec api isort src --check-only
