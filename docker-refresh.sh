#!/usr/bin/env bash
set -euo pipefail

echo "=== Docker Full Refresh ==="
echo "This will remove ALL containers, images, volumes, and networks."
read -rp "Are you sure? (y/N): " confirm
if [[ "${confirm,,}" != "y" ]]; then
  echo "Aborted."
  exit 0
fi

echo "Stopping all running containers..."
containers=$(docker ps -aq)
if [[ -n "$containers" ]]; then
  docker stop $containers
  echo "Removing all containers..."
  docker rm -f $containers
else
  echo "No containers found."
fi

echo "Removing all images..."
images=$(docker images -aq)
if [[ -n "$images" ]]; then
  docker rmi -f $images
else
  echo "No images found."
fi

echo "Removing all volumes..."
volumes=$(docker volume ls -q)
if [[ -n "$volumes" ]]; then
  docker volume rm -f $volumes
else
  echo "No volumes found."
fi

echo "Removing all non-default networks..."
networks=$(docker network ls --filter type=custom -q)
if [[ -n "$networks" ]]; then
  docker network rm $networks
else
  echo "No custom networks found."
fi

echo "=== Docker refresh complete ==="
