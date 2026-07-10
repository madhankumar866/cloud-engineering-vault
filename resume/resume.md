# MADHAN KUMAR S

**Chennai, India (Open to remote)** | 6+ Years Experience

**Email:** madhansaba.r@gmail.com | **Mobile:** 8667537020 | **LinkedIn:** linkedin.com/in/mk-201861185 | **GitHub:** madhankumar866

## PROFESSIONAL SUMMARY

- **Platform Engineer | SRE** with 6+ years of experience architecting and operating high-scale AWS/EKS platforms with a focus on **FinOps**, **GitOps**.
- Proven track record in CI/CD pipeline engineering, zero-downtime releases, and Infrastructure-as-Code implementation.
- Specialized in building **Kubernetes Control Planes** using **Crossplane** and **Terraform**, reducing infrastructure lead times from days to minutes.
- Eliminated operational toil by designing **self-service infrastructure bots** and high-performance **Golang** observability tools.
- Deep experience in **Service Mesh (Istio)** and advanced traffic engineering to ensure zero-downtime releases and multi-tenant isolation.
- Strategic focus on **Cost Optimization**, using **Karpenter** and **KEDA** to cut cloud compute spend by up to **80%**.

## PROFESSIONAL EXPERIENCE

### Platform Engineer / SRE
**ADP India** | Chennai | Mar 2024 - Present

**Key Achievement: Proprietary Routing & Noisy Neighbor Mitigation**
- **The Problem:** Multi-tenant EKS environments suffered from performance degradation and latency spikes due to "noisy neighbor" workloads consuming shared resources.
- **The Solution:** Architected and implemented a **proprietary "Farm-Based" routing model** using **Istio Service Mesh** to isolate workloads into logical farms with dedicated resource boundaries and circuit-breaking policies.
- **The Impact:** Eliminated cross-tenant performance interference, stabilized service SLAs, and provided granular traffic control for high-volume release cycles.

**Key Achievement: Real-Time Release Observability Platform (Golang)**
- **The Problem:** Operations teams spent ~8 hours per release cycle manually monitoring application promotions, leading to high toil and lack of audit trails.
- **The Solution:** Engineered a high-performance logging engine and live dashboard in **Golang** to ingest and visualize promotion events.
- **The Impact:** Eliminated 100% of manual monitoring toil (8 man-hours saved per release) and provided an immutable audit trail for velocity analysis.

**Key Achievement: Multi-Account Analytics Control Plane (Redash/Crossplane)**
- **The Problem:** Fragmented data silos across 5 AWS accounts prevented real-time observability and required manual data exports for analysis.
- **The Solution:** Architected a central "Analytics Hub" on EKS using Redash and Athena. Leveraged **Crossplane** to automate the provisioning of cross-account IAM roles and Athena workgroups.
- **The Impact:** Enabled secure, federated SQL access to 4 separate environment data lakes with zero data movement, reducing data-source onboarding time from **3 days to 30 minutes**.

**Key Achievement: Event-Driven Testing Infrastructure (KEDA)**
- **The Problem:** Traditional Selenium Grid was either under-provisioned (causing CI/CD bottlenecks) or over-provisioned (wasting $5000s in idle compute).
- **The Solution:** Architected and deployed an event-driven Selenium Grid on EKS using KEDA to scale dynamically from 0 to 200+ browser nodes.
- **The Impact:** Reduced testing infrastructure spend by **~80%** through Scale-to-Zero and Spot instance integration, while improving test execution speed.

**Key Responsibilities:**
- **Infrastructure Control Plane:** Leveraged **Crossplane** for K8s-native, GitOps-driven cloud resource provisioning. Integrated **Atlantis** with **Terragrunt** to automate AWS provisioning (RDS, Kafka, OpenSearch) via PR workflows.
- **Service Mesh & Networking:** Led the migration from Ambassador to **Istio**, implementing mTLS for zero-trust security and advanced traffic management (canary, shadowing).
- **FinOps & Scaling:** Configured **Karpenter** for just-in-time node provisioning and established a shared AWS Ingress Controller with reusable Load Balancers, significantly reducing monthly cloud costs.
- **GitOps Excellence:** Implemented and maintained **ArgoCD** with Microsoft SSO using AppSets for multi-tenant RBAC and streamlined application delivery.
- **Developer Productivity:** Developed custom **Infrastructure Bots (Python/Go)** allowing developers to provision sandbox environments via ticket-based approvals, reducing lead time from 2 days to <10 minutes.
- **Observability Migration:** Architected the migration of observability pipelines to **Cribl**, optimizing log routing and data reduction to slash Splunk/Datadog ingestion costs.

**Technologies/Tools Used:**
- **Platform:** Kubernetes (EKS), Crossplane, Istio, Karpenter, KEDA, Helm
- **IaC & CI/CD:** Terraform, Terragrunt, Atlantis, ArgoCD, Argo Workflows, Jenkins
- **Languages:** Golang, Python, Shell Scripting
- **Observability:** Cribl, Prometheus, Grafana, Splunk, Datadog
- **Security:** Kyverno, Snyk, SonarQube, IAM, RBAC

### DevOps / Linux Engineer
**Genxlead Solutions Pvt Ltd** | Chennai | Aug 2019 - Feb 2024

**Key Responsibilities:**
- Architected and implemented cloud-native service decomposition (microservices and serverless) using AWS Lambda and SAM to modernize monolithic applications
- Managed multi-cloud infrastructure deployments and maintained Infrastructure-as-Code (IaC) pipelines
- Designed and maintained Kubernetes clusters on AWS EKS with Helm charts for container orchestration
- Oversaw database migrations from on-premises systems to cloud platforms (Snowflake, AWS RDS)
- Implemented CI/CD pipelines using GitOps practices with ArgoCD for automated deployments
- Monitored and optimized application performance using CloudWatch, Prometheus, and distributed tracing tools
- Collaborated with development teams to troubleshoot infrastructure issues and optimize resource utilization
- Automated infrastructure provisioning and scaling using Terraform and CloudFormation

**Achievements:**
- **Platform Modernization:** Modernized monolithic systems using microservices and serverless patterns, improving deployment agility and reducing infrastructure costs through auto-scaling
- **Database Transformation:** Led migration of on-premises databases to Snowflake with zero downtime, enhancing analytics capabilities and data query performance
- **Performance Optimization:** Improved application response times by 40% through CDN integration and optimized Helm charts, enhancing user experience
- **Test Automation Modernization:** Reduced manual test automation effort by 100% by transitioning from Windows-based manual framework to fully automated Kubernetes-backed infrastructure on AWS EKS
- **Scalability Enhancement:** Integrated AWS Fargate Profiles enabling infrastructure to handle 80% more test jobs during peak loads without manual intervention
- **Network Optimization:** Enhanced network flexibility through intelligent IP address management and API-driven infrastructure interactions

**Technologies/Tools Used:**
- **Cloud Platforms:** AWS (EC2, Lambda, ECS, EKS, RDS, S3, CloudWatch, API Gateway, SAM)
- **Container & Orchestration:** Kubernetes, Docker, Helm, AWS Fargate, AWS EKS
- **Infrastructure-as-Code:** Terraform, CloudFormation, AWS SAM
- **CI/CD & GitOps:** ArgoCD, Git, GitOps practices
- **Databases:** Snowflake, AWS RDS, on-premises database systems
- **Monitoring & Logging:** Prometheus, Jaeger, CloudWatch, ELK Stack
- **Automation & Scripting:** Python, Boto3, Bash, Shell scripting
- **Testing:** Selenium, KEDA, test automation frameworks
- **Other Tools:** CDN solutions, IP address management, AWS API Gateway

## SKILLS

**Programming & Automation**
- Golang (Infrastructure Tools)
- Python (BotOps, Automation)
- Bash/Shell Scripting

**Cloud & Infrastructure Control Plane**
- AWS (EKS, Lambda, RDS, S3, IAM, Route53)
- Crossplane (K8s-native Infrastructure)
- Terraform / Terragrunt
- Atlantis (Pull Request Automation)

**Container Orchestration & Mesh**
- Kubernetes (EKS)
- Istio Service Mesh (Traffic Mgmt, mTLS)
- Karpenter (Just-in-time Node Provisioning)
- KEDA (Event-driven Autoscaling)
- Helm (Package Management)

**GitOps & CI/CD**
- ArgoCD (AppSets, Multi-tenancy)
- Argo Workflows (Release Orchestration)
- GitHub Actions / Jenkins
- Kyverno (Policy as Code)

**Observability & FinOps**
- Cribl (Log Routing & Data Reduction)
- Prometheus & Grafana
- Splunk / ELK Stack / Datadog
- Cost Optimization (Compute Efficiency)

**Security & Compliance**
- Snyk & SonarQube (Shift-Left Security)
- RBAC & Zero-Trust Architecture
- Audit Controls & Vulnerability Scanning

## PROJECTS

- **Multi-Account EC2 Fleet Management System** (Python, AWS Lambda, Boto3, API Gateway) — Centralized EC2 management across multiple AWS accounts, cutting manual operational overhead.
- **Scalable Selenium Test Automation on AWS EKS** (Kubernetes, Helm, Fargate, Prometheus, ArgoCD) — Fully automated, dynamically scaling test framework handling 80% more jobs at peak.

## CERTIFICATIONS

- **AWS Certified Solutions Architect** | Verify via Credly

## EDUCATION

**Bachelor of Computer Applications (BCA)**
**D.G. Vaishnav Colleges** | Chennai | 2013 - 2016