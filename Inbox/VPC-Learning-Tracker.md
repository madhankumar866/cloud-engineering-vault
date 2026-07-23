# VPC Learning Tracker — Canvas-Mapped Progress

## 📊 Overview
- **Goal:** Complete VPC mastery (Labs 3–5 + capstone)
- **Start Date:** July 21, 2026
- **Target Date:** August 4, 2026 (14 days)
- **Status:** 🟡 In Progress
- **Canvas Reference:** [[0.VPC.Index.canvas|0.VPC.Index.canvas]]

---

## 🗺️ Canvas Section Overview

| Canvas Section | Status | Topics | Days |
|---|---|---|---|
| 🏗️ Core Building Blocks | ✅ Complete | Default VPC, Subnets, Route Tables | — |
| 🚪 Gateways & Internet Access | 🟡 In Progress | IGW, NAT Gateway | Lab 3–5 |
| 🔒 Security & Monitoring | 🟡 In Progress | SG/NACLs, Flow Logs | Lab 4–5 |
| 🌐 Connectivity | ✅ Complete | Peering, VPN, Transit GW | — |
| 🔌 Services & Edge | 🟡 In Progress | Route53, PrivateLink, CloudFront, RAM, ALB/NLB | Day 1–2 |
| 🧪 Hands-On Labs | 🟡 In Progress | Lab 3, 4, 5 | Day 3–10 |

---

## ✅ Phase 1: Concepts (Days 1–2) — ~6h

### Day 1 (July 21) — Monday | Canvas: ALB vs NLB

**Canvas Nodes:**
- 🟡 [[3.ALB vs NLB|ALB vs NLB]] (Review)

**What to Do:**
- [ ] Read [3.ALB vs NLB.md](../../Knowledge%20Base/AWS/3.ALB%20vs%20NLB.md) (2h)
- [ ] Take notes on ALB vs NLB differences
- [ ] Understand when to use each (use case mapping)

**Verification:**
- Can you explain 3 key differences between ALB and NLB?
- Do you understand when to choose ALB over NLB?

**Time Tracking:**
- Planned: 2h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** VPC Advanced Features + open questions

---

### Day 2 (July 22) — Tuesday | Canvas: VPC Advanced Features

**Canvas Nodes:**
- 🔴 [[4. VPC Advanced Features|VPC Advanced Features]] (Not Started)
- 📝 [[0.VPC.Index.canvas#Open Questions|Open Questions]] (Canvas section)

**What to Do:**
- [ ] Read [4. VPC Advanced Features.md](../../Knowledge%20Base/AWS/4.%20VPC%20Advanced%20Features.md) (1.5h)
- [ ] Study ENI, IPAM, advanced routing concepts
- [ ] Answer 2–3 priority open questions (1.5h)
  - CIDR sizing + Terraform loops?
  - NAT Instance vs NAT GW cost?
  - Cross-account VPC peering?

**Verification:**
- Can you explain what ENI and IPAM do?
- Can you outline a cross-account peering solution?

**Time Tracking:**
- Planned: 3h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Lab 3 (NAT Gateway) start

---

## ✅ Phase 2: Hands-On Labs (Days 3–10) — ~16.5h

### Days 3–4 (July 23–24) | Canvas: Lab 3 — NAT Gateway

**Canvas Nodes:**
- 🟡 [[VPC/NAT Gateway|NAT Gateway]] (canvas: nat_gw)
- 🟡 [[VPC/VPC-Terraform-Labs|VPC Terraform Labs]] (canvas: labs_note)

**Lab Overview:**
Build a **private subnet with outbound internet** via NAT Gateway.

**What to Do:**
- [ ] Review [[VPC/NAT Gateway|NAT Gateway]] guide (30 min)
- [ ] Review [[VPC/VPC-Terraform-Labs|Lab 3 instructions]] (30 min)
- [ ] Write Terraform: VPC → Public subnet (IGW) → Private subnet (NAT GW) → Route tables (1.5h)
- [ ] Deploy to AWS (1h)
- [ ] Test: Launch EC2 in private subnet, verify outbound internet works (1h)
- [ ] Teardown & document (30 min)

**Terraform Verification Steps:**
```bash
# After terraform apply:
terraform plan  # Should show clean plan

# SSH to bastion (public), then SSH to private instance
ssh -J ec2-user@BASTION private-instance
ping 8.8.8.8  # Should work (outbound via NAT)
ssh -i key.pem someone@private-ip  # Should fail (not reachable from internet)
```

**Success Criteria:**
- Private EC2 can reach internet ✓
- Private EC2 cannot be SSH'd into from public internet ✓
- NAT Gateway logs show traffic flowing through it ✓

**Time Tracking:**
- Day 3 Planned: 2h | Completed: _ | Blockers: _
- Day 4 Planned: 1.5h | Completed: _ | Blockers: _

**Daily Log — Day 3:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Lab 3 deploy + test

---

**Daily Log — Day 4:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Lab 4 (SG + NACLs) start

---

### Days 5–6 (July 25–26) | Canvas: Lab 4 — Security Groups + NACLs

**Canvas Nodes:**
- 🟡 [[VPC/Security-group & NACLS|Security Groups & NACLs]] (canvas: sg_nacl)
- 🟡 [[VPC/VPC Flow Logs|VPC Flow Logs]] (canvas: flow_logs)
- 🟡 [[VPC/VPC-Terraform-Labs|VPC Terraform Labs]] (canvas: labs_note)

**Lab Overview:**
Build **multi-layer firewall rules** (SG + NACL) to restrict traffic.

**What to Do:**
- [ ] Review [[VPC/Security-group & NACLS|SG vs NACL differences]] (30 min)
- [ ] Read [[VPC/VPC Flow Logs|VPC Flow Logs guide]] (30 min)
- [ ] Write Terraform: Create subnets + restrictive NACL + SG rules (1.5h)
- [ ] Deploy: Web tier (SG: 80/443), App tier (SG: 3000), DB tier (SG: 5432 only from app) (1h)
- [ ] Test traffic flow: Web → App → DB should succeed; Web → DB should fail (1h)
- [ ] Debug with VPC Flow Logs (1h)

**Terraform Verification Steps:**
```bash
# After terraform apply:
# From web instance, test app access:
curl -X GET http://app-instance:3000  # Should work

# From web instance, test DB access:
nc -zv db-instance 5432  # Should timeout (NACL blocks)

# Enable VPC Flow Logs and check:
aws logs tail /aws/vpc/flowlogs --follow
# Look for REJECT records for Web→DB traffic
```

**Success Criteria:**
- Web tier can reach App tier ✓
- App tier can reach DB tier ✓
- Web tier cannot reach DB tier (blocked by NACL) ✓
- Flow Logs show ACCEPT/REJECT decisions ✓

**Time Tracking:**
- Day 5 Planned: 2h | Completed: _ | Blockers: _
- Day 6 Planned: 2h | Completed: _ | Blockers: _

**Daily Log — Day 5:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Lab 4 testing + Flow Logs debugging

---

**Daily Log — Day 6:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Lab 5 (3-Tier Capstone) design

---

### Days 7–10 (July 27–30) | Canvas: Lab 5 — 3-Tier Capstone

**Canvas Nodes:**
- 🟡 [[VPC/Subnets|Subnets]] (canvas: subnets)
- 🟡 [[VPC/Internet Gateway (IGW)|IGW]] (canvas: igw)
- 🟡 [[VPC/NAT Gateway|NAT Gateway]] (canvas: nat_gw)
- 🟡 [[VPC/Security-group & NACLS|SG & NACLs]] (canvas: sg_nacl)
- 🟡 [[VPC/VPC-Terraform-Labs|VPC Terraform Labs]] (canvas: labs_note)

**Lab Overview:**
Build a **production-grade 3-tier architecture**:
- **Web Tier** (Public subnet + ALB): Publicly accessible
- **App Tier** (Private subnet): Only reachable from Web Tier
- **DB Tier** (Isolated private subnet): Only reachable from App Tier

**What to Do:**

**Day 7 (Design Phase — 2h):**
- [ ] Sketch CIDR blocks (VPC: 10.0.0.0/16, Public: 10.0.1.0/24, App: 10.0.2.0/24, DB: 10.0.3.0/24)
- [ ] Plan subnets across AZs (e.g., 2 public, 2 app, 2 DB)
- [ ] Design SG rules:
  - Web SG: 80/443 from 0.0.0.0/0
  - App SG: 3000 from Web SG only
  - DB SG: 5432 from App SG only
- [ ] Plan route tables: Public (IGW), App/DB (NAT GW)

**Days 8–9 (Build & Deploy — 6h):**
- [ ] Write Terraform modules: VPC, Subnets, Gateways, SGs, Route Tables (3h)
- [ ] Deploy VPC infrastructure (1h)
- [ ] Launch EC2 instances in each tier (1h)
- [ ] Set up ALB for Web tier (1h)

**Day 10 (Test & Document — 2h):**
- [ ] Test: Web → App → DB connectivity (1h)
- [ ] Debug with Flow Logs if issues (30 min)
- [ ] Document architecture: Diagrams + notes (30 min)

**Terraform Verification Steps:**
```bash
# After terraform apply:
terraform plan  # Clean plan

# From Web tier (via ALB):
curl -X GET http://alb-dns-name/  # Should reach app tier

# SSH to Web instance, then SSH to App instance:
ssh -i web-key.pem ec2-user@web-ip
ssh -i app-key.pem ec2-user@app-private-ip

# From App tier, test DB connectivity:
mysql -h db-private-ip -u root  # Should connect

# Verify traffic flows:
aws logs tail /aws/vpc/flowlogs --follow
# Look for patterns: Web→ALB (✓) → App (✓) → DB (✓)
```

**Success Criteria:**
- All 3 tiers deployed ✓
- Web tier publicly accessible via ALB ✓
- App tier reachable only from Web tier ✓
- DB tier reachable only from App tier ✓
- Security rules enforced correctly ✓
- Architecture documented ✓

**Time Tracking:**
- Day 7 Planned: 2h | Completed: _ | Blockers: _
- Day 8 Planned: 3h | Completed: _ | Blockers: _
- Day 9 Planned: 3h | Completed: _ | Blockers: _
- Day 10 Planned: 2h | Completed: _ | Blockers: _

**Daily Log — Day 7:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Build Terraform modules

---

**Daily Log — Day 8:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Deploy infrastructure + EC2 instances

---

**Daily Log — Day 9:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Test & document capstone

---

**Daily Log — Day 10:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Deep dives + remaining questions

---

## ✅ Phase 3: Deep Dives & Integration (Days 11–14) — ~7–10h

### Day 11 (July 31) — Thursday | Canvas: Open Questions

**Canvas Nodes:**
- 📝 [[0.VPC.Index.canvas#Open Questions|Open Questions]] (Canvas section)

**What to Do:**
- [ ] Answer remaining open questions (2–3h):
  1. CIDR sizing + Terraform `for_each` loops (lab-3 question)
  2. NAT Instance vs NAT GW cost breakeven (lab-3 question)
  3. Cross-account VPC peering with Terraform (lab-5 question)
  4. NACL rule numbering best practices (lab-4 question)
  5. Transit Gateway integration with Terraform modules (optional)

**Verification:**
- Write a 1-paragraph answer to each question
- Link to relevant Terraform code or AWS docs

**Time Tracking:**
- Planned: 3h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Optional Transit Gateway expansion

---

### Day 12 (August 1) — Friday | Canvas: Optional — Transit Gateway

**Canvas Nodes:**
- 🟡 [[2.Transit Gateway|Transit Gateway]] (canvas: tgw)

**What to Do (Optional):**
- [ ] Expand Lab 5 to multi-VPC architecture:
  - Deploy 2nd VPC (10.1.0.0/16)
  - Create Transit Gateway
  - Attach both VPCs to TGW
  - Route traffic between VPCs
- [ ] Document TGW integration with Terraform modules

**Verification:**
- Can ping between VPCs via TGW?
- Terraform modules reusable across VPCs?

**Time Tracking:**
- Planned: 2–3h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Pending topics or review

---

### Day 13 (August 2) — Saturday | Canvas: Optional — Pending Topics

**Canvas Nodes:**
- 📋 [[0.VPC.Index.canvas#To-Do / Not Started|Pending Topics]] (Canvas section)

**What to Do (Optional):**
- [ ] Choose 1–2 pending topics to explore (1–2h):
  - Traffic Mirroring (for debugging)
  - Elastic Network Interfaces (ENI) deep dive
  - VPC IPAM (IP Address Manager)
  - AWS Network Firewall
  - Gateway Load Balancer (GWLB)

**Verification:**
- Document 1 use case for each topic explored

**Time Tracking:**
- Planned: 1–2h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Tomorrow's Focus:** Final review + finalize capstone

---

### Day 14 (August 3) — Sunday | Canvas: Final Review

**Canvas Nodes:**
- 📊 [[0.VPC.Index.canvas#Study Progress|Study Progress]] (Canvas section)

**What to Do:**
- [ ] Review capstone architecture (30 min)
- [ ] Update canvas progress: Mark all nodes complete (1h)
- [ ] Compile final summary: Key learnings, Terraform patterns, lessons (30 min)

**Success Criteria:**
- All 15 concept topics reviewed ✓
- Labs 3–5 capstone complete ✓
- Open questions answered ✓
- Canvas marked 100% complete ✓

**Time Tracking:**
- Planned: 2h | Completed: _ | Blockers: _

**Daily Log:**

**Completed:** 

**Notes:** 

**Status:** ✅ VPC Mastery Complete!

---

## 📊 Progress Summary

| Phase | Status | Canvas Coverage | Time Investment |
|-------|--------|-----------------|-----------------|
| Phase 1: Concepts | ⏳ Pending | ALB/NLB, Advanced Features | 0h / 6h |
| Phase 2: Labs | ⏳ Pending | NAT GW, SG/NACLs, 3-Tier | 0h / 16.5h |
| Phase 3: Deep Dives | ⏳ Pending | Questions, TGW, Pending Topics | 0h / 7–10h |
| **TOTAL** | 🟡 **In Progress** | **5/5 sections** | **0h / ~30h** |

---

## 🎯 Canvas Node Status Tracker

**Update this as you progress:**

| Canvas Node | Status | Canvas Color | Days | Concept Link |
|---|---|---|---|---|
| ALB vs NLB | ⏳ | 🟡 Yellow (In Progress) | Day 1 | [[3.ALB vs NLB]] |
| VPC Advanced Features | ⏳ | 🔴 Red (Not Started) | Day 2 | [[4. VPC Advanced Features]] |
| NAT Gateway | ⏳ | 🟡 Yellow (In Progress) | Days 3–4 | [[VPC/NAT Gateway]] |
| SG & NACLs | ⏳ | 🟡 Yellow (In Progress) | Days 5–6 | [[VPC/Security-group & NACLS]] |
| VPC Flow Logs | ✅ | 🟢 Green (Mastered) | Days 5–6, 10 | [[VPC/VPC Flow Logs]] |
| Subnets | ✅ | 🟢 Green (Mastered) | Days 7–10 | [[VPC/Subnets]] |
| IGW | ✅ | 🟢 Green (Mastered) | Days 7–10 | [[VPC/Internet Gateway (IGW)]] |
| Transit Gateway | ⏳ | 🟡 Yellow (In Progress) | Day 12 (Optional) | [[2.Transit Gateway]] |

---

## 📚 Quick Reference Links

**Phase 1 Concepts:**
- [[3.ALB vs NLB]] | [[4. VPC Advanced Features]]

**Phase 2 Labs:**
- [[VPC/VPC-Terraform-Labs|Lab Instructions]] | [[VPC/NAT Gateway|Lab 3]] | [[VPC/Security-group & NACLS|Lab 4]] | [[VPC/Subnets|Lab 5]]

**Canvas:**
- [[0.VPC.Index.canvas|VPC Learning Map]]

**Vault Instructions:**
- [[GEMINI.md#VPC Mastery Learning Path|VPC Learning Path in GEMINI.md]]

---

## 💾 How to Use This Tracker

### Morning (5 min)
1. Find today's day entry
2. Review canvas nodes to cover
3. Open relevant concept links
4. Check yesterday's time spent

### During Work (Ongoing)
- Reference verification steps
- Update time as you go
- Note blockers immediately

### Evening (10 min)
1. Fill in "Completed" section
2. Log time spent
3. Write 1-2 notes on learnings
4. Update tomorrow's focus
5. On canvas completion, update canvas node status

---

**Ready? Start Day 1 now → Open [3.ALB vs NLB.md](../../Knowledge%20Base/AWS/3.ALB%20vs%20NLB.md) and begin reading!**
