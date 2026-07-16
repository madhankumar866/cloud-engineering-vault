# Comprehensive DevOps & SRE Master Study Plan

This plan is built to cover comprehensive AWS architecture, networking, EKS, and GitOps workflows. 

## 🟢 1. The Foundation: AWS Architecture & Networking
- [ ] **Networking & VPC**
  - [ ] [[1. VPC Deep Dive]] — the isolated network container, CIDR blocks, default VPC
  - [ ] [[VPC/Subnets|Subnets]] — public vs private, CIDR sizing, reserved addresses
  - [ ] [[VPC/Router & Route Tables|Router & Route Tables]] — how traffic is directed inside a VPC
  - [ ] [[VPC/Internet Gateway (IGW)|Internet Gateway (IGW)]] — door to the public internet
  - [ ] [[VPC/NAT Gateway|NAT Gateway]] — private subnets reach internet (outbound only)
  - [ ] [[VPC/Security-group & NACLS|Security Groups & NACLs]] — stateful vs stateless firewalls
  - [ ] [[VPC/VPC Flow Logs|VPC Flow Logs]] — visibility & auditing of network traffic
  - [ ] [[VPC/VPC-Peering|VPC Peering]] — direct 1:1 connection between two VPCs
  - [ ] [[2.Transit Gateway|Transit Gateway (TGW), BGP & AWS RAM]] — hub-and-spoke for many VPCs & on-prem
  - [ ] [[VPC/VPN-connections|VPN Connections]] — secure encrypted tunnel over the internet to on-prem
  - [ ] [[5. Route53 & Hybrid DNS|Direct Connect, Hybrid DNS & Route53]] — dedicated wire + DNS bridging across hybrid networks
  - [ ] [[7. PrivateLink & VPC Endpoints|PrivateLink & VPC Endpoints]] — private access to AWS services without traversing the internet
  - [ ] [[8. AWS RAM|AWS RAM]] — share TGW, subnets & other resources across accounts
  - [ ] [[3.ALB vs NLB|Load Balancers (ALB vs NLB)]] — target groups, listener rules, cross-zone routing
  - [ ] [[6. CloudFront & Edge Locations|CloudFront (CDN) & Edge Locations]] — caching & global edge delivery
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

## ⚪ 6. Agentic AI & AI-Augmented Engineering
- [ ] **Core Concepts**
  - [ ] [[1. AI Agents Fundamentals]] (Tool use, orchestration, planner-executor pattern)
- [ ] **LangGraph**
  - [ ] Stateful graph workflows, cycles, checkpoints
- [ ] **Model Context Protocol (MCP)**
  - [ ] Client-server architecture, tools, resources, prompts — [modelcontextprotocol.io](https://modelcontextprotocol.io/docs/getting-started/intro)
- [ ] **AI-Augmented IDP**
  - [ ] Wrap an existing infra bot (fleet mgmt / sandbox provisioning) behind an MCP server
  - [ ] Copilot-style release automation (design impact review, identify pipeline failure points)

## 🟤 7. Programming & Scripting
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
