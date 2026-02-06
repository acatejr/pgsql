# Project: pgsql

Dockerized PostgreSQL 17 sandbox with PostGIS, pgvector, and geocoding extensions.

## Architecture

- **Dockerfile** — Builds a PostgreSQL 17 image with PostGIS 3, pgvector, and related extensions.
- **compose.yml** — Docker Compose service (`sandbox-postgres`) exposing port 5432, with a persistent named volume and bridge network.
- **extensions.sql** — Init script that creates extensions on first run: `vector`, `postgis`, `postgis_topology`, `fuzzystrmatch`, `postgis_tiger_geocoder`.
- **.env** — Environment variables (credentials). **Never read or commit this file.**

## Common Commands

```sh
# Start the database
docker compose up -d

# Rebuild after Dockerfile changes
docker compose up -d --build

# Stop and remove containers (preserves data volume)
docker compose down

# Stop and destroy data volume
docker compose down -v

# Connect via psql
docker exec -it sandbox-postgres psql -U <user> -d <database>
```

## Rules

- **Never read or expose the `.env` file.** It contains secrets.
- Do not commit `.env` to version control.
- When adding new PostgreSQL extensions, add the `apt-get install` line in the `Dockerfile` and a corresponding `CREATE EXTENSION` in `extensions.sql`.
