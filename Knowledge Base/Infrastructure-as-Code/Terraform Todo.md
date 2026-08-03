---
tags:
  - iac/terraform
  - review
status: in-progress
Repetition: rep/1
Next-Review: 
---
# Terraform To-Do & Lab Roadmap

This document organizes hands-on Terraform infrastructure tasks, practical lab exercises, and concept reviews across the vault.

---

## 🏗️ VPC Terraform Labs (VPC Mastery Learning Path)
Work through these exercises in order, applying infrastructure as code principles to reinforce VPC theory:

- [ ] **Lab 1 — Basic VPC & Subnets:** Create custom VPC (`10.0.0.0/16`) with 4 subnets across 2 AZs using `for_each` [[VPC/VPC-Terraform-Labs#🧪 Lab 1 — Basic VPC + Subnets|Lab 1 Guide]]
- [ ] **Lab 2 — IGW & Public Routes:** Attach `aws_internet_gateway` and configure public route table associations [[VPC/VPC-Terraform-Labs#🧪 Lab 2 — Internet Gateway + Public Route Table|Lab 2 Guide]]
- [ ] **Lab 3 — NAT Gateway:** Allocate `aws_eip` and deploy NAT Gateway in public subnets to enable outbound private subnet routing [[VPC/VPC-Terraform-Labs#🧪 Lab 3 — NAT Gateway for Private Subnets|Lab 3 Guide]]
- [ ] **Lab 4 — Security Groups & NACLs:** Implement multi-layered firewall defense testing stateful `aws_security_group` vs stateless `aws_network_acl` rules [[VPC/VPC-Terraform-Labs#🧪 Lab 4 — Security Groups & NACLs|Lab 4 Guide]]
- [ ] **Lab 5 — 3-Tier Capstone Architecture:** Build end-to-end production architecture (Public Web Tier with ALB $\rightarrow$ Private App Tier $\rightarrow$ Isolated DB/RDS Tier) using modularized Terraform configuration [[VPC/VPC-Terraform-Labs#🧪 Lab 5 — Full 3-Tier VPC (Capstone)|Lab 5 Guide]]

---

## ⚙️ Core IaC & Engineering Tasks
- [ ] Set up remote backend using Amazon S3 (`terraform.tfstate`) and DynamoDB state locking [[Terraform/2. State Management|2. State Management]]
- [ ] Practice writing dry reusable modules for Networking, Compute, and Database infrastructure [[Terraform/3. Modules|3. Modules]]
- [ ] Implement advanced dynamic HCL techniques (`for_each`, `dynamic`, `lifecycle`, and `depends_on` meta-arguments) [[Terraform/4. Loops & Meta-Arguments|4. Loops & Meta-Arguments]]
- [ ] Configure CI/CD checks & validation pipeline (`terraform fmt`, `terraform validate`, `tflint`, and `checkov`) [[Terraform/6. Testing & Validation|6. Testing & Validation]]
- [ ] Explore multi-environment workspace management strategies (Workspace-per-env vs. Directory-per-env) [[Terraform/5. Workspaces & Environments|5. Workspaces & Environments]]

---

## 🔗 Connections (Zettelkasten)
- **Relates to:** [[1. Terraform Core Concepts]]
- **Relates to:** [[VPC/VPC-Terraform-Labs|VPC Terraform Labs]]
- **Relates to:** [[1. VPC Deep Dive]]
- **Core Use Case:** Central task tracking and milestone progress management for mastering HashiCorp Terraform across AWS enterprise workloads.
