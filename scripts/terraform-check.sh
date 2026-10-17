
#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="$PROJECT_DIR/terraform"

echo "Formatting Terraform files..."
terraform -chdir="$TF_DIR" fmt -recursive

echo "Initializing Terraform..."
terraform -chdir="$TF_DIR" init

echo "Validating Terraform configuration..."
terraform -chdir="$TF_DIR" validate

echo "Planning development environment..."
terraform -chdir="$TF_DIR" plan \
  -var-file="environments/dev/terraform.tfvars" \
  -refresh=false

echo "Planning production environment..."
terraform -chdir="$TF_DIR" plan \
  -var-file="environments/prod/terraform.tfvars" \
  -refresh=false

echo "Terraform checks completed successfully."
echo "No Terraform apply was performed."
