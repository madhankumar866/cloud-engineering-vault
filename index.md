# Comprehensive DevOps & SRE Master Study Plan

This plan is built to cover comprehensive AWS architecture, networking, EKS, and GitOps workflows. 

## 🟢 1. The Foundation: AWS Architecture & Networking
- [ ] **Networking & VPC (Deep Dive)**
  - [ ] [[1. VPC Deep Dive]] (Subnets, Route Tables, IGW, NAT)
  - [ ] VPC Peering, Transit Gateway (TGW), BGP, AWS RAM
  - [ ] AWS Direct Connect, Hybrid DNS, Route53
  - [ ] CloudFront (CDN) & Edge Locations
  - [ ] ALB vs NLB (Target groups, listener rules, cross-zone routing)
- [ ] **Compute & Serverless**
  - [ ] EC2 Fleet Management (Review your Python/Boto3 project)
  - [ ] AWS Lambda (Python & Golang), API Gateway (Proxy integrations, throttling, authorizers)
  - [ ] SNS & SQS (Asynchronous Event-Driven Architectures)
  - [ ] ECS & Fargate Profiles (Review your test automation project)
- [ ] **Storage & Databases**
  - [ ] S3 Bucket Policies & Object lifecycle
  - [ ] AWS RDS & Snowflake basics (Review your database migration project)
  - [ ] AWS DMS (Database Migration Service)
  - [ ] Data Analytics (Redash, Athena) - *Review your Multi-Account Analytics Control Plane project*
- [ ] **Security & Multi-Account**
  - [ ] IAM (Roles, STS, Federation, Policy conditions)
  - [ ] AWS Organizations & Service Control Policies (SCPs)
  - [ ] AWS Secrets Manager & Systems Manager Parameter Store (SSM)

## 🟡 2. Automation: Infrastructure as Code (IaC)
- [ ] **Terraform (The Standard)**
  - [ ] [[Terraform]] (Modules, Remote State Management, State Locking)
  - [ ] [[Terragrunt]] (DRY Terraform)
  - [ ] [[Atlantis]] (Pull Request Automation workflows)
- [ ] **AWS Native IaC**
  - [ ] [[AWS CDK CloudFormation]] & AWS SAM

## 🔵 3. Compute & Orchestration: Kubernetes & EKS
- [ ] **EKS Fundamentals & Security**
  - [ ] [[EKS Architecture]] (Control Plane vs Worker Nodes)
  - [ ] EKS IAM Roles for Service Accounts (IRSA) & K8s RBAC
- [ ] **Service Mesh & Networking**
  - [ ] Istio (mTLS, Zero-trust, Canary/Shadow deployments, farm-based routing) 
- [ ] **Advanced Scaling & Resource Management**
  - [ ] Karpenter (Just-in-time Node Provisioning)
  - [ ] KEDA (Event-driven Autoscaling - Review your event-driven Selenium project)
  - [ ] HPA & StatefulSets vs Deployments
- [ ] **Kubernetes Native Infrastructure**
  - [ ] Crossplane (Provisioning AWS resources via K8s, Compositions) 
  - [ ] Helm Chart packaging and optimization

## 🟣 4. Delivery: CI/CD & GitOps
- [ ] **GitOps Practices**
  - [ ] [[ArgoCD]] (AppSets, Multi-tenant RBAC, Sync phases)
  - [ ] [[Argo Workflows]] (Release Orchestration)
- [ ] **Pipeline Automation**
  - [ ] [[GitHub Actions]]
  - [ ] [[Jenkins]] (Caching, stashing, parallelism)

## 🟠 5. Observability, FinOps & Security
- [ ] **Monitoring & Logging**
  - [ ] Prometheus, Grafana, Jaeger (Distributed Tracing)
  - [ ] Cribl (Log Routing & Data Reduction pipelines)
  - [ ] CloudWatch, Splunk, Datadog, ELK stack 
- [ ] **FinOps (Cost Optimization)**
  - [ ] Spot Instance integration & Scale-to-zero strategies
  - [ ] Analyzing idle compute
- [ ] **Shift-Left Security & Compliance**
  - [ ] Kyverno (Kubernetes Policy as Code)
  - [ ] Snyk, SonarQube (Vulnerability Scanning in CI/CD)

## 🟤 6. Programming & Scripting
- [ ] **Python (Automation & Bots)**
  - [ ] Object-Oriented Programming (Classes, Methods)
  - [ ] Boto3 for AWS Automation
  - [ ] Building Infrastructure Bots (Review your ticket-based sandbox provisioning)
- [ ] **Golang**
  - [ ] High-performance infrastructure tools & Concurrency
  - [ ] Real-time logging engines (Review your release observability platform)
- [ ] **Bash/Shell**
  - [ ] Process management & signal trapping

---

## 📅 Daily Tracking Log
Add your daily updates below to track what you learned and jot down questions.

### [[YYYY-MM-DD]]
- **Topic**: 
- **Notes**: 
- **Questions for Tutor**: 
