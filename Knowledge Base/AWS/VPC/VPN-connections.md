---
tags:
  - aws/networking
  - vpc
  - review
  - completed
status: completed
Repetition: rep/2
Next-Review: 2026-08-03
---
# VPN Connections

## 📖 Core Concepts

### The Feynman Analogy
> [!NOTE]
> Imagine trying to connect your remote branch offices or individual workers to your main office. Instead of paying to lay down thousands of miles of expensive private physical cables across the country, you create secure, encrypted Virtual Private Network (VPN) tunnels directly over the public internet. This gives you the security of a private network at a fraction of the cost, leveraging the global infrastructure of the internet.

AWS offers several VPN connectivity options to securely link your Amazon Virtual Private Cloud (VPC) to on-premises systems and remote users:

### Key Terminology
- **Virtual Private Gateway (VGW)**: The VPN concentrator on the AWS side of a Site-to-Site VPN connection, attached to a single VPC.
- **Customer Gateway (CGW)**: A resource that represents the physical gateway device or software appliance in your on-premises network. You provide its IP address and configuration.
- **Transit Gateway (TGW)**: A network transit hub that can scale connections across multiple VPCs and on-premises systems, allowing a single VPN connection to route traffic to multiple VPCs.

### AWS VPN Options

| VPN connectivity option | Description |
| --- | --- |
| **AWS Site-to-Site VPN** | Creates an IPsec VPN connection between your VPC and your remote network. On the AWS side, a **Virtual Private Gateway (VGW)** or **Transit Gateway (TGW)** provides **two VPN endpoints (tunnels)** in separate Availability Zones for automatic failover. You configure your Customer Gateway (CGW) device on the remote side. [AWS Site-to-Site VPN User Guide](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html). |
| **AWS Client VPN** | A managed client-based VPN service that enables users to securely access AWS or on-premises resources from any location using an OpenVPN-based client. Establishes secure **TLS sessions** and integrates with Active Directory, SAML 2.0 (e.g., Okta/Entra ID), or client certificates. [AWS Client VPN Administrator Guide](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/). |
| **AWS VPN CloudHub** | A hub-and-spoke model allowing multiple branch offices to communicate with each other (and the VPC) through a single Virtual Private Gateway (VGW) using Site-to-Site VPNs. [VPN CloudHub Guide](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPN_CloudHub.html). |
| **Third-Party Software VPN** | Run a partner software appliance (e.g., pfSense, Cisco ASAv, OpenVPN) on an EC2 instance in a public subnet. The customer is fully responsible for managing, patching, licensing, and scaling. [AWS Marketplace](https://aws.amazon.com/marketplace/search/results/ref=brs_navgno_search_box?searchTerms=vpn). |

### Static vs. Dynamic (BGP) Routing (Site-to-Site VPN)
- **Static Routing**: Requires you to manually define route destinations. Necessary if your Customer Gateway does not support Border Gateway Protocol (BGP).
- **Dynamic Routing**: Uses **BGP** to automatically propagate routes. If one of the two AWS VPN tunnels goes down, BGP routing automatically switches path traffic to the secondary tunnel without manual intervention.

### Secure Private Transit (Direct Connect + VPN)
You can combine **AWS Direct Connect (DX)** with **AWS Site-to-Site VPN** to run an IPsec-encrypted tunnel over a dedicated, private connection. This ensures both **consistent, high-speed network performance** and **end-to-end encryption** for sensitive workloads. [Direct Connect User Guide](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Welcome.html).

## 🎯 Interview / Exam Answer
If an interviewer asks, “How does AWS VPN work?”, you can answer it like this:

> AWS VPN is used to connect an on-premises network or branch office to an AWS VPC securely over the public internet. In the Site-to-Site VPN model, AWS provides a Virtual Private Gateway or Transit Gateway on the AWS side, and the customer configures a Customer Gateway on their side. The connection uses IPsec and typically has two tunnels for redundancy. Client VPN is used for individual users, while Direct Connect + VPN is used when you want private, reliable connectivity with encryption.

### 30-Second Answer
AWS VPN provides secure encrypted connectivity between your on-premises network and your AWS VPC. The most common option is Site-to-Site VPN, which uses IPsec and a Virtual Private Gateway or Transit Gateway on the AWS side, with a Customer Gateway on your side. It supports redundancy with two tunnels and can use BGP for dynamic routing.

### 1-Minute Answer
AWS offers several VPN options depending on the use case. Site-to-Site VPN connects an office or data center to a VPC over the internet using IPsec. Client VPN connects individual users to AWS resources. VPN CloudHub helps multiple branch offices connect through a central gateway. In the architecture, AWS provides the VPN endpoint on the AWS side, while the customer configures the gateway on their side. Routing can be static or dynamic with BGP, and for higher reliability, AWS creates two tunnels in separate Availability Zones.

## 🏗️ Architecture Explanation
A typical Site-to-Site VPN architecture looks like this:

- The customer gateway device sits in the on-premises network.
- The VPN tunnel travels over the internet to the AWS side.
- AWS attaches the VPN endpoint to a Virtual Private Gateway or Transit Gateway.
- The gateway is connected to the VPC route tables, which direct traffic into the correct subnets.
- Security groups and NACLs still control access to resources inside the VPC.
- For high availability, AWS provisions two VPN tunnels in separate Availability Zones.
- With BGP enabled, routing is dynamic and traffic can fail over automatically if one tunnel fails.

In short: the VPN creates a secure encrypted path between two networks, while routing and security controls decide how traffic flows inside AWS.

---
## 📋 Summary (Exam Memory)

- **Site-to-Site VPN** — IPsec tunnel over the internet between your VPC (VGW/TGW) and on-prem (CGW); AWS provisions **2 tunnels** per connection for automatic failover
- **Client VPN** — managed OpenVPN service for individual remote users; supports AD, SAML 2.0, and certificate auth
- **VPN CloudHub** — hub-and-spoke model letting multiple branch offices talk to each other and the VPC through one VGW
- **Third-party software VPN** — self-managed appliance on EC2; full control but you own patching, HA, and scaling
- **Static routing** = manual routes; **Dynamic (BGP)** = auto route propagation + automatic failover between tunnels
- VPN over **Direct Connect** = IPsec over DX for encrypted + dedicated private transit (DX alone is unencrypted)
- VPN is quick to set up but has variable latency (internet-dependent); **Direct Connect** is more reliable but takes weeks to provision

---

## 🔗 Connections (Zettelkasten)
- **Part of:** [[1. VPC Deep Dive]]
- **Relates to:** [[2.Transit Gateway|Transit Gateway]], [[5. Route53 & Hybrid DNS|Route53 & Hybrid DNS]]
- **Core Use Case:** Bridging on-premises corporate offices (Site-to-Site VPN), interconnecting branch offices (CloudHub), or enabling remote workforce access (Client VPN) to private AWS subnets.

---

## 🛠️ Study Aids

### 🧠 Mind Map

```mermaid
flowchart LR
    VPN((AWS VPN<br/>Options))
    VPN --> S2S["<b>Site-to-Site VPN</b><br/>IPsec tunnel · VGW/TGW to CGW<br/>2 active tunnels for redundancy"]
    VPN --> CVPN["<b>Client VPN</b><br/>OpenVPN client · TLS tunnel<br/>SAML / AD / Cert auth"]
    VPN --> CH["<b>CloudHub</b><br/>Hub-and-spoke routing<br/>Office-to-office communication"]
    VPN --> DXVPN["<b>DX + VPN</b><br/>IPsec over Direct Connect<br/>Dedicated & encrypted path"]

    classDef root fill:#4A90E2,stroke:#2E5C8A,color:#fff,stroke-width:2px
    classDef node fill:#7B68EE,stroke:#5A4BA0,color:#fff
    class VPN root
    class S2S,CVPN,CH,DXVPN node
```

### 🗂️ Flashcards

#flashcards/aws/11_vpn-connection

**What is the difference between a Virtual Private Gateway (VGW) and a Customer Gateway (CGW) in AWS Site-to-Site VPN?**
?
The Virtual Private Gateway (VGW) is the VPN concentrator on the AWS side of the connection attached to your VPC. The Customer Gateway (CGW) represents the physical appliance or software application on the on-premises/remote side of the connection.
<!--SR:!2026-08-05,3,250-->

---

**How does AWS ensure high availability for an AWS Site-to-Site VPN connection?**
?
AWS automatically provisions two active VPN tunnels in separate Availability Zones (endpoints) for every Site-to-Site VPN connection. The customer is responsible for configuring their Customer Gateway device to support automatic failover between these two tunnels.
<!--SR:!2026-08-05,3,250-->

---

**What is AWS VPN CloudHub and what is its primary use case?**
?
AWS VPN CloudHub is a feature that allows multiple remote sites (e.g., branch offices) connected via Site-to-Site VPNs to communicate directly with each other and the VPC using a hub-and-spoke model through a single Virtual Private Gateway (VGW).
<!--SR:!2026-08-05,3,250-->

---

**Which protocol does AWS Client VPN run on, and what authentication methods does it support?**
?
AWS Client VPN uses the OpenVPN protocol (TLS session). It supports Active Directory integration, SAML 2.0 (for identity providers like Okta/Azure AD), and Mutual Authentication (using client certificates).
<!--SR:!2026-08-05,3,250-->

---

**Why would you run a Site-to-Site VPN over an AWS Direct Connect (DX) connection?**
?
To combine the high-speed, consistent private connection of Direct Connect with the end-to-end encryption of IPsec VPN. (Direct Connect alone is not encrypted by default).
<!--SR:!2026-08-05,3,250-->

