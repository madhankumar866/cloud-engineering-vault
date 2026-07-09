## round 1: Question

Based on the transcript of your interview, here are the questions and technical scenarios the interviewer asked you, organized by topic:

### **1. Roles & Responsibilities**

* Can you please share your roles and responsibilities for what you have done in all your previous organizations?
* What kind of coding were you doing for multiple accounts (in Python for Lambda)?
* Why would you remove and attach IPs again? I don't understand the use case. *(Follow-up regarding the email marketing platform)*
* Were you writing the Lambda code by yourself or were the developers writing this code?

### **2. AWS Services & Architecture**

* How does API Gateway handle throttling and rate limiting for APIs?
* How can we check your APIs in your API Gateway?
* What are the different types of integrations using API Gateway?
* Have you faced any CORS (Cross-Origin Resource Sharing) issues while using API Gateway?
* How can we handle versioning using API Gateway?
* Have you created different versions of a Lambda function, and how would you route traffic to different versions of a Lambda function?
* How can we achieve cross-zone load balancing using an AWS Load Balancer?
* Do we require sticky sessions while we are working with an Application Load Balancer (ALB)? What happens if you don't use a sticky session?
* Is a WebSockets connection better than sticky sessions?
* Have you ever used OAI (Origin Access Identity) and OAC (Origin Access Control) on Cloudfront?
* How would you secure different connections using Cloudfront?
* How would you deploy so many instances in multiple accounts? What tool were you using?
* How would you log into multiple accounts if you use Terraform? Why would you use Terraform instead of AWS Organizations to manage that?
* Have you created any alarms or metrics using Cloud Watch? What kind of metrics have you set for?
* Have you used CloudFormation anytime in your AWS experience?
* **Scenario-based question:** Suppose I have an IAM user who belongs to a group that has full access to an S3 bucket. However, the permission boundary for that specific user allows only read access to that S3 bucket. Which permission would prevail?

### **3. Kubernetes (EKS)**

* Have you by any chance worked on an EKS cluster in AWS?
* How were you deploying the EKS Cluster for the first time?
* In EKS, how does the leader node get elected in a node group?
* What is the difference between HPA (Horizontal Pod Autoscaler) and KEDA? Which one will scale according to the event source?
* What is the difference between a ClusterIP and a LoadBalancer service in Kubernetes?
* What is the use of sidecar containers and init containers? Why do we use init containers?
* **Troubleshooting scenario:** Suppose a container is mandating a `CrashLoopBackOff` or error, and when checking the executing logs on the container, it shows a "resource label" or "reference label" missing. What could be the issue?
* What is the difference between a StatefulSet and a Deployment? Which one would have a persistent volume?

### **4. Infrastructure as Code (Terraform & Atlantis)**

* Where are you using Terraform in any of your projects?
* What is the difference between `terraform import` and the `terraform state` command?
* How would you segregate different environments in terms of Terraform? Have you used Terraform workspaces?

### **5. CI/CD & GitOps (Jenkins & Argo CD)**

* What pipeline management tool were you using (Jenkins, GitLab, or Git Mutations)?
* What is the purpose of cache and stash in Jenkins?
* How would you execute parallelism of stages in Jenkins?
* How would you handle application synchronization in Argo CD? How do you do the synchronization when changes occur in your repository?
* Why are we using Application Sets in Argo CD?
* How would you manage your secrets in Argo CD? (Do you use HashiCorp Vault or Secret Manager?)

### **6. Linux & Scripting**

* Which automation scripting language are you better with: Python or Bash?
* How would you catch a terminated signal (like an accidental termination of an HTTPD process) within a Bash script? What command can you use?

### **7. Practical/Coding Phase**

* Can you share your screen? *(The interviewer then provided 3 live Python coding tasks in a code editor, checking for syntax, logic, collection types, and proper indentation).*


-----
## round 2: Question

Based on the transcript of your interview, here are the questions and technical scenarios the interviewer asked you in round 2, organized by topic:

### **1. AWS Organizations & Multi-Account Management**

* Can you explain AWS Landing Zones? If you have around 80 to 100 AWS accounts, how do you manage them collectively? What type of structure or AWS services would you use for their management?
* How many AWS accounts were you managing in your specific project?
* When using AWS Organizations, what were the functions of the master account versus the other (member) accounts?

### **2. Core Networking (Transit Gateway & VPC Peering)**

* How were you managing the networking between multiple AWS accounts?
* Suppose you have instances across multiple accounts and regions, and you need them to communicate with each other with full ingress and egress connectivity. How would you set up that architecture?
* If you have instances across many regions, how many Transit Gateways would you create? How will the routing work?
* How do you share a Transit Gateway across multiple accounts? How do you set up the route tables and attachments?
* Are you aware of AWS RAM (Resource Access Manager)? How is it used with Transit Gateway?
* If a Transit Gateway is created and shared from the hub networking account, what is the next step you need to do on the spoke account side to complete the connectivity?

### **3. Hybrid Connectivity & NAT vs. IGW**

* Can you explain what an AWS Site-to-Site VPN is, and have you configured one?
* Let's talk about NAT Gateways and Internet Gateways. How do they work, what are their functionalities, and what are their distinct use cases?
* How does an Internet Gateway differ fundamentally from a NAT device? 
* **Routing scenario:** Let's say you have an EC2 instance sitting inside a private subnet. If an external user on the internet wants to send an inbound request to that private instance, how does that request travel? What AWS resources are required?
* **Routing scenario (reversed):** What if the private instance needs to reach out to the internet to download a Python package or security update, but no one from the internet should be able to initiate a connection to it. What do you use there?
* u have a ec2 instance in private subnet, how do you reach the instance from outside of your internet.

### **4. Load Balancers (ALB vs. NLB)**

* When would you choose an Application Load Balancer (ALB) over a Network Load Balancer (NLB)?
* Inside an ALB, you have Listeners and Target Groups. What can be registered as a valid "Target" in an ALB target group? Can a Network Load Balancer be a target for an ALB?
* Can the reverse happen? Can an ALB be a target for an NLB?
* When configuring ALB Listener Rules, what type of conditions can you specify to route traffic to different target groups?


------
## old one:

### **1. Advanced Multi-Account Hub-and-Spoke Networking**

When a platform team manages hundreds of AWS accounts, they completely outlaw individual Internet Gateways and NAT Gateways per account because it's a massive security risk and financial drain. Instead, they build a **Centralized Inspection/Egress Hub Architecture**.

- **The Hub-and-Spoke Blueprint:** * You have a central **Networking AWS Account**. In it, you deploy a central **AWS Transit Gateway (TGW)**.
    
    - You use **AWS Resource Access Manager (RAM)** to share that TGW resource across your entire AWS Organization. Once shared, your application team accounts can attach their "Spoke VPCs" directly to it.
        
- **TGW Route Table Isolation (The Sandbox Pattern):**
    
    - _The Requirement:_ Spoke A (Dev) and Spoke B (Prod) must never talk to each other, but both must talk to the Shared Services VPC (for Jenkins, Artifactory, or DNS).
        
    - _The Execution:_ You create **multiple routing tables inside the TGW**.
        
        - **Spoke Route Table:** Associated with Spoke A and B attachments. It has only _one_ explicit route: `0.0.0.0/0` (or `10.x.x.x` internal range) targeting the **Shared Services VPC attachment**. It completely lacks routes pointing to other spokes, so packets literally have no path to cross boundaries.
            
        - **Shared Services Route Table:** Associated with the Shared Services VPC attachment. It has explicitly propagated routes for _all_ spokes, allowing it to reply or initiate traffic out to any sandbox safely.
            

### **2. IaC Automation via AWS Service Catalog**

Since they mentioned packaging templates into **AWS Service Catalog**, they want to know if you can build "Guardrails." They don’t trust developers with admin access to AWS, so they use Service Catalog to allow self-service provision safely.

- **The Pipeline Flow:** 1. Your platform team writes modular **CloudFormation Templates** or **Terraform configurations**.
    
    2. You upload these templates as **Products** and group them into **Portfolios** inside AWS Service Catalog.
    
    3. You share these portfolios with developer IAM groups.
    
- **Launch Constraints (Crucial Concept):**
    
    - _The Problem:_ A developer needs to spin up an EC2 instance or an S3 bucket, but their personal IAM user profile has **zero permissions** to create S3 buckets or EC2 instances (Least Privilege).
        
    - _The Solution:_ You assign a **Launch Constraint** (an IAM Role managed by the platform team) to the Service Catalog Product. When the developer clicks "Launch," Service Catalog temporarily assumes that privileged background execution role to build the infrastructure on behalf of the user. The developer gets their platform resource, but they never see or hold the actual administrative AWS access keys.
        

### **3. Packet Tracing & Advanced Load Balancing Nuances**

They pressed you hard on routing fundamentals because an architect must be able to visualize a packet moving through every firewall, table, and interface.

- **NLB targeting an ALB (The Static IP Pattern):**
    
    - _The Interview Scenario:_ "Our application requires a static, white-listed public IP address on the internet, but we need advanced Layer 7 path-based routing (`/api` vs `/static`) and SSL termination at the load balancer. How do you design this?"
        
    - _The Platform Answer:_ You position an **NLB at the very front** facing the public internet because NLBs natively provide static, elastic IP addresses per Availability Zone. You then configure the NLB's target group type explicitly to **Application Load Balancer** and select your internal ALB. The NLB handles the static IP entry point and streams the raw TCP traffic directly down to your ALB, which executes the fine-grained Layer 7 HTTP header and path routing rules.
        

### **4. Enterprise Hybrid Connectivity**

When a corporate security team asks you to link up a physical corporate data center to your central cloud network, you must weigh cost against reliability.

- **AWS Site-to-Site VPN vs. Direct Connect (DX):**
    
    - **Site-to-Site VPN:** Deployed in minutes. It runs over the public internet using encrypted IPsec tunnels. It is cheap but subject to the performance jitter and bandwidth fluctuations of the public internet. Max bandwidth is typically restricted to $1.25 \text{ Gbps}$ per tunnel.
        
    - **Direct Connect (DX):** A dedicated, private, physical fiber-optic cable laid down between your corporate data center and an AWS Direct Connect location. It completely bypasses the public internet. It offers ultra-low latency, maximum security compliance, and massive, predictable bandwidth scales ($1 \text{ Gbps}$ up to $100 \text{ Gbps}$). It takes weeks/months to provision through a telecom provider.
        
- **Centralizing Hybrid Traffic via TGW:**
    
    - Instead of terminating a VPN or DX connection into every single separate VPC, you terminate the Direct Connect Gateway (DXGW) or VPN connection directly onto the central **Transit Gateway (TGW)**. This immediately distributes corporate network hybrid access to _all_ attached spoke VPCs simultaneously, simplifying your enterprise edge layout.