#!/usr/bin/env bash
# EraLens Cloud Agent environment — install (idempotent, runs after checkout).
# Prepares system deps (Docker for PostgreSQL), Node deps, Prisma client, and
# pre-pulls the Postgres image so the first boot is fast. Safe to run repeatedly.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Make Node / pnpm available in non-interactive shells (base image ships nvm).
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" >/dev/null 2>&1 || true
corepack enable >/dev/null 2>&1 || true

echo "==> [install] Ensuring Docker + friends are installed"
if ! command -v docker >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get update -y
  sudo apt-get install -y --no-install-recommends \
    docker.io docker-compose-v2 fuse-overlayfs iptables postgresql-client
  # Handle any conffile prompts left half-configured (e.g. fuse3).
  sudo dpkg --configure -a --force-confdef --force-confold || true
fi

echo "==> [install] Configuring Docker daemon for the nested VM (fuse-overlayfs)"
sudo mkdir -p /etc/docker
echo '{"storage-driver":"fuse-overlayfs"}' | sudo tee /etc/docker/daemon.json >/dev/null
# Legacy iptables works more reliably than nft inside the nested VM.
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1 || true
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy >/dev/null 2>&1 || true
# Let the agent user talk to the Docker socket without sudo.
sudo groupadd -f docker
sudo usermod -aG docker "$(id -un)" || true

echo "==> [install] Installing workspace dependencies"
pnpm install --frozen-lockfile

echo "==> [install] Preparing API env file"
[ -f apps/api/.env ] || cp apps/api/.env.example apps/api/.env

echo "==> [install] Generating Prisma client"
pnpm --filter @eralens/api db:generate

# Pre-pull the Postgres image into the snapshot so the first boot doesn't wait
# on a registry pull. Requires a running daemon; start one transiently if needed.
echo "==> [install] Pre-pulling Postgres image"
TRANSIENT_DOCKERD_PID=""
if ! sudo docker info >/dev/null 2>&1; then
  sudo dockerd >/tmp/dockerd-install.log 2>&1 &
  TRANSIENT_DOCKERD_PID=$!
  for _ in $(seq 1 30); do sudo docker info >/dev/null 2>&1 && break; sleep 1; done
fi
sudo docker pull postgres:16-alpine || true
if [ -n "$TRANSIENT_DOCKERD_PID" ]; then
  # Stop only the daemon we started, by PID (snapshots capture disk, not processes).
  sudo kill "$TRANSIENT_DOCKERD_PID" >/dev/null 2>&1 || true
  wait "$TRANSIENT_DOCKERD_PID" 2>/dev/null || true
fi

echo "==> [install] Done"
