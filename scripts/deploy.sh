
#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$PROJECT_DIR/application"

IMAGE_NAME="${IMAGE_NAME:-ai-ecommerce-app}"
IMAGE_TAG="${IMAGE_TAG:-1.0.5}"

echo "Starting local deployment preparation..."
cd "$APP_DIR"

echo "Step 1: Running application tests..."
npm test

echo "Step 2: Building Docker image..."
cd "$PROJECT_DIR"
docker build -f docker/Dockerfile \
  -t "${IMAGE_NAME}:${IMAGE_TAG}" .

echo "Step 3: Verifying Docker image..."
docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" >/dev/null

echo
echo "Build and verification completed successfully."
echo "Image: ${IMAGE_NAME}:${IMAGE_TAG}"
echo "No AWS resources were modified."
echo "To update ECS, review and execute a separate deployment procedure."
