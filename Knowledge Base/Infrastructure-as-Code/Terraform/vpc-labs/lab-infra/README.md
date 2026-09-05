# VPC Labs Infrastructure (Kind + MiniStack)

This directory provides the local infrastructure to run all 5 **VPC Terraform Labs** completely offline, free, and without incurring AWS cloud bills, using **Kind** (Kubernetes in Docker) and **MiniStack** (a lightweight, drop-in AWS emulator).

---

## 🎯 Architecture

```text
Host (macOS)
┌─────────────────────────────────────────────────────────────┐
│  Terraform CLI (Lab 1, 2, 3, 4, 5)                          │
│  AWS Endpoint: http://localhost:4566                        │
└──────────────────────────┬──────────────────────────────────┘
                           │ (hostPort: 4566)
┌──────────────────────────▼──────────────────────────────────┐
│  Kind Cluster ('vpc-labs')                                  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Control-Plane Node (containerPort: 31566)             │  │
│  │ ┌───────────────────────────────────────────────────┐ │  │
│  │ │ Service: ministack-svc (NodePort: 31566)          │ │  │
│  │ └─────────────────────┬─────────────────────────────┘ │  │
│  │                       │                               │  │
│  │ ┌─────────────────────▼─────────────────────────────┐ │  │
│  │ │ Pod: ministack (ministackorg/ministack:latest)     │ │  │
│  │ │ Namespace: lab-infra                              │ │  │
│  │ │ Port: 4566 (EC2, ELBv2, RDS, IAM, STS)            │ │  │
│  │ └───────────────────────────────────────────────────┘ │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Worker Node                                           │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 Lab Requirements Matrix (Labs 1 – 5)

| Lab | Directory | Key AWS Resources Tested | MiniStack Emulated Services | Verification |
| :--- | :--- | :--- | :--- | :--- |
| **Lab 1** | `../lab-1` | `aws_vpc`, `aws_subnet` | `ec2` | `terraform output public_subnet_ids` |
| **Lab 2** | `../lab-2` | `aws_internet_gateway`, `aws_route_table`, `aws_route_table_association` | `ec2` | `terraform output public_rt_id` |
| **Lab 3** | `../lab-3` | `aws_eip`, `aws_nat_gateway`, private route tables | `ec2` | `terraform output nat_gateway_ids` |
| **Lab 4** | `../lab-4` | `aws_security_group`, `aws_network_acl` | `ec2` | `terraform output web_sg_id`, `public_nacl_id` |
| **Lab 5** | `../lab-5` | `aws_vpc`, subnets (6x), IGW, NAT GW, `aws_lb`, `aws_instance`, `aws_db_subnet_group` | `ec2`, `elbv2`, `rds` | 3-Tier stack: ALB $\rightarrow$ App EC2 $\rightarrow$ DB Subnet Group |

---

## 🚀 Quick Start (Automated)

Run the automated setup script from this directory:

```bash
cd "Knowledge Base/Infrastructure-as-Code/Terraform/vpc-labs/lab-infra"
./setup-cluster.sh
```

The script will:
1. Validate that Docker is running.
2. Spin up the multi-node Kind cluster `vpc-labs` using `kind-config.yaml`.
3. Load the local `ministackorg/ministack:latest` Docker image into Kind.
4. Deploy the `ministack-k8s.yaml` manifests into the `lab-infra` namespace.
5. Poll `http://localhost:4566/_ministack/health` until ready.

---

## 🛠️ Manual Step-by-Step

If you prefer executing the commands manually:

### 1. Ensure Docker & Kind are in PATH
```bash
export PATH="$HOME/.docker/bin:/opt/homebrew/bin:$PATH"
```

### 2. Create the Kind Cluster
```bash
kind create cluster --config kind-config.yaml
```

### 3. Preload the MiniStack Image into Kind
```bash
kind load docker-image ministackorg/ministack:latest --name vpc-labs
```

### 4. Apply Kubernetes Manifests
```bash
kubectl apply -f ministack-k8s.yaml
```

### 5. Verify Pod and Service Status
```bash
kubectl get pods -n lab-infra -o wide
kubectl get svc -n lab-infra
```

### 6. Verify Health Endpoint from Host
```bash
curl http://localhost:4566/_ministack/health
```

---

## 🧪 Testing Your First Lab (Lab 1)

Once the infrastructure is running, test Lab 1:

```bash
cd "../lab-1"
terraform init
terraform plan
terraform apply -auto-approve
terraform output
```

Clean up Lab 1 resources when finished:
```bash
terraform destroy -auto-approve
```

---

## 💡 Standalone Docker Compose Option (Alternative)

If you ever want to run MiniStack without the Kind cluster:

```bash
docker compose up -d
# Teardown:
docker compose down
```

---

## 🧹 Tearing Down the Cluster

When you are completely finished with your study session:

```bash
./teardown-cluster.sh
# Or manually:
kind delete cluster --name vpc-labs
```
