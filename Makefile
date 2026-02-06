.PHONY: up build down destroy psql stop

up: ## Start the database
	docker compose up -d

build: ## Rebuild after Dockerfile changes
	docker compose up -d --build

down: ## Stop and remove containers (preserves data volume)
	docker compose down

destroy: ## Stop and destroy data volume
	docker compose down -v

psql: ## Connect via psql
	docker exec -it sandbox-postgres psql -U $${POSTGRES_USER} -d $${POSTGRES_DB}

stop: ## Stop the container
	docker compose stop

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'
