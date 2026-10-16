# AI E-Commerce DevOps Platform

An end-to-end DevOps project demonstrating application development, automated CI/CD, container security scanning, AWS deployment, and monitoring.

## Architecture

Developer → GitHub → Jenkins → Application Tests → Docker Build → Trivy Security Scan → Amazon ECR → Amazon ECS Fargate → Application Load Balancer → Users

CloudWatch provides monitoring dashboards and CPU and memory alarms. Amazon SNS delivers alarm notifications by email.

## Technology Stack

- **Application:** Node.js, Express
- **Version Control:** Git, GitHub
- **CI/CD:** Jenkins
- **Containerization:** Docker
- **Security Scanning:** Trivy
- **AWS:** Amazon ECR, ECS Fargate, Application Load Balancer, CloudWatch, SNS
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **Orchestration:** Kubernetes
- **Monitoring Configuration:** Prometheus

## Application Endpoints

The application listens on port `3000`.

| Endpoint | Purpose |
|---|---|
| `/` | Application status and version |
| `/health` | Health check |
| `/products` | Returns sample product data |

## CI/CD Pipeline

The Jenkins pipeline performs these stages:

1. Checkout source code from GitHub.
2. Install application dependencies.
3. Run automated application tests.
4. Build the Docker image.
5. Scan the image using Trivy.
6. Authenticate with Amazon ECR and push the image.

## AWS Deployment

The application runs as a container on Amazon ECS Fargate. An internet-facing Application Load Balancer routes HTTP requests to the application. The ECS task security group permits application traffic from the load balancer security group.

## Monitoring and Alerting

- CloudWatch dashboard for ECS CPU and memory utilization.
- CPU utilization alarm with an 80% threshold.
- Memory utilization alarm with an 80% threshold.
- Amazon SNS email notifications.

Email delivery depends on the SNS subscription being confirmed and the alarm entering the configured state.

## Local Setup

Requirements: Node.js, npm, and Git.

```bash
cd application
npm ci
npm test
node app.js
```

The application defaults to port `3000`.

## Repository Structure

```text
application/     Node.js application and tests
docker/          Dockerfile
jenkins/         Jenkins pipeline
terraform/       Terraform configuration
ansible/         Ansible inventory and playbook
kubernetes/      Kubernetes manifests
monitoring/      Prometheus configuration
scripts/         Setup, deployment, and health-check scripts
reports/         Security scan reports, if retained
```

## Project Status

The application health check and products endpoint have been verified through the AWS Application Load Balancer. The Jenkins pipeline and ECR image push have also been exercised.

Terraform, Ansible, Kubernetes, and Prometheus configurations should be reviewed individually before claiming that all infrastructure and monitoring components are fully automated.

## Cost and Security Notes

AWS resources such as Application Load Balancers, running Fargate tasks, and public IPv4 addresses may incur charges.

Never commit AWS access keys, secret keys, passwords, or other credentials to GitHub. Use Jenkins credentials or an appropriate AWS role for deployment.
