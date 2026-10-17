#!/usr/bin/env bash
set -euo pipefail

APP_URL="${APP_URL:-http://ai-ecommerce-alb-1063057650.ap-south-1.elb.amazonaws.com}"

echo "Checking application health: ${APP_URL}/health"

if curl --fail --silent --show-error \
  --max-time 15 "${APP_URL}/health"; then
  echo
  echo "Health check passed."
else
  echo
  echo "Health check failed. Verify the AWS load balancer and ECS service."
  exit 1
fi