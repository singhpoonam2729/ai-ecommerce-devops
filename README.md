# AI E-Commerce DevOps Platform

A DevOps project demonstrating application development, automated testing, containerization, CI/CD, container security scanning, AWS deployment, and monitoring instrumentation.

## Architecture

Developer → GitHub → Jenkins → Application Tests → Docker Build → Trivy Security Scan → Amazon ECR → Amazon ECS Fargate → Application Load Balancer → Users

Amazon CloudWatch provides ECS monitoring dashboards and CPU/memory alarms. Amazon SNS is configured for alarm notifications. The application also exposes Prometheus metrics.

## Technology Stack

- **Application:** Node.js, Express
- **Version Control:** Git, GitHub
- **CI/CD:** Jenkins
- **Containerization:** Docker
- **Security Scanning:** Trivy
- **AWS:** Amazon ECR, ECS Fargate, Application Load Balancer, CloudWatch, SNS
- **Infrastructure as Code:** Terraform (pending implementation)
- **Configuration Management:** Ansible
- **Orchestration:** Kubernetes
- **Application Metrics:** prom-client
- **Monitoring Configuration:** Prometheus

## Application Endpoints

The application listens on port `3000`.

| Endpoint | Purpose |
|---|---|
| `/` | Application status and version |
| `/health` | Health check |
| `/products` | Returns sample product data |
| `/metrics` | Prometheus-format application and process metrics |

## Automated Tests

The application test suite uses Node.js's built-in test runner and Supertest.

Run the tests:

```bash
cd application
npm ci
npm test
```

The current test suite covers the home, health, products, and Prometheus metrics endpoints. All four tests passed during local validation.

## CI/CD Pipeline

The Jenkins pipeline is configured to:

1. Check out source code from GitHub.
2. Install application dependencies.
3. Run application tests.
4. Build the Docker image.
5. Scan the image for HIGH and CRITICAL vulnerabilities using Trivy.
6. Authenticate with Amazon ECR and push the image.

The pipeline uses Jenkins credentials for AWS authentication. The current pipeline configuration uses image tag `1.0.4`; image `1.0.5` has been built locally with the metrics changes but has not yet been pushed to ECR.

## AWS Deployment

The application has been verified running on Amazon ECS Fargate behind an internet-facing Application Load Balancer.

The ECS task security group is configured to allow application traffic from the load balancer security group.

The deployed AWS application was previously verified through the load balancer's home, health, and products endpoints. The new metrics changes have not yet been deployed to AWS.

## Monitoring and Alerting

### Amazon CloudWatch

- ECS CPU and memory utilization dashboard.
- CPU utilization alarm configured with an 80% threshold.
- Memory utilization alarm configured with an 80% threshold.
- Amazon SNS email notifications configured for alarms.

### Prometheus

The Express application exposes `/metrics` using `prom-client`. The metrics endpoint returned HTTP 200 during local testing.

A Prometheus scrape configuration is present at `monitoring/prometheus/prometheus.yml`. Actual Prometheus scraping has not yet been verified.

## Configuration Management

An Ansible inventory and playbook are provided. The current playbook verifies that Docker is installed and that image `ai-ecommerce-app:1.0.4` exists locally.

The playbook passed syntax validation and executed successfully against localhost. It does not currently deploy the application to a remote host.

## Kubernetes

Kubernetes Deployment and Service manifests are provided in `kubernetes/`.

The Deployment specifies three replicas, HTTP health probes, and CPU/memory resource requests and limits. The Service uses the `ClusterIP` type.

Both manifests passed Kubernetes server-side dry-run validation against Minikube. The application has not yet been deployed and verified through these manifests.

The Deployment references the private ECR image tagged `1.0.4`; a real cluster requires permission to pull that image.

## Terraform Status

Terraform is installed locally, but `terraform/main.tf`, `terraform/variables.tf`, and `terraform/outputs.tf` are currently empty. Terraform infrastructure automation is not yet implemented.

The configured AWS CLI identity also lacks permission for `ec2:DescribeVpcs`. No Terraform apply has been performed.

## Repository Structure

```text
application/     Node.js application, dependencies, and tests
docker/          Dockerfile
jenkins/         Jenkins pipeline
terraform/       Terraform entry-point files (pending implementation)
ansible/         Inventory and playbook
kubernetes/      Deployment and Service manifests
monitoring/      Prometheus scrape configuration
scripts/         Setup, deployment, and health-check scripts
reports/         Security scan reports
```

## Cost and Security Notes

AWS resources such as running Fargate tasks, Application Load Balancers, and public IPv4 addresses may incur ongoing charges.

Do not commit AWS access keys, secret keys, passwords, or other credentials to GitHub. Use Jenkins credentials or an appropriate AWS IAM role for deployment.

Review Trivy findings against the current image before release. The committed security report may refer to an older image.

## Project Status

The application, four automated tests, local Docker build, Ansible localhost playbook, and Kubernetes manifest validation have been verified.

The AWS deployment and Jenkins/ECR workflow were verified previously. The new metrics-enabled image has not been deployed to AWS.

Remaining work includes Terraform implementation, real Prometheus scraping, remote Ansible deployment, and a final review of the security report and deployment automation.
