
#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Preparing AI E-Commerce DevOps project..."
cd "$PROJECT_DIR"

for cmd in docker node npm; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd is not installed or not in PATH."
    exit 1
  fi
done

echo "Docker version:"
docker --version

echo "Node.js version:"
node --version

echo "npm version:"
npm --version

echo "Installing application dependencies..."
cd "$PROJECT_DIR/application"
npm ci

echo "Setup completed successfully."
