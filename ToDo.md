
- [ ] Write and publish LinkedIn post about Uber's Superuser Gateway pattern
- [ ] Complete [[VPC/VPC-Terraform-Labs|VPC Terraform Labs]] (Labs 1–5 Capstone)
- [ ] Answer VPC Open Question: CIDR sizing & dynamic subnetting using Terraform `for_each` loops
- [ ] Answer VPC Open Question: NAT Gateway vs. NAT Instance cost breakeven analysis (FinOps evaluation)
- [ ] Answer VPC Open Question: Cross-account VPC peering automation with Terraform
- [ ] Answer VPC Open Question: NACL rule numbering spacing & governance best practices
- [ ] Answer VPC Open Question: Transit Gateway integration with modular multi-VPC Terraform deployments
- [ ] Explore pending VPC deep dives: VPC IPAM, Elastic Network Interfaces (ENIs) attachment behavior, and AWS Network Firewall
- [x] OOC revision ✅ 2026-08-02
- [x] Flesh out [[4. VPC Advanced Features]] note ✅ 2026-08-03

---

## 🔔 Topics Due for Review Today (Spaced Repetition Queue)
```dataview
TABLE Repetition AS "Current Stage", Next-Review AS "Due Date"
FROM "Knowledge Base"
WHERE Next-Review <= date(today) AND status != "completed" AND Repetition != "rep/mastered"
SORT Next-Review ASC
```

---

## TODO List

```tasks
not done
filename includes Todo.md
```

## 🟡 Terraform & IaC Roadmap Tasks
```tasks
not done
path includes Infrastructure-as-Code
group by filename
```

# sample Query ToDo Query Base
## 🌍 Global Tasks (All Open Tasks)

**Using the Tasks Plugin** (Organized cleanly by folder):
```tasks
not done
group by folder
group by filename
sort by due reverse
```

**Using the Dataview Plugin** (Alternative view):
```dataview
TASK
WHERE !completed
GROUP BY file.folder
```

---

## 📁 Folder-Scoped Tasks

**Example 1: Show tasks ONLY from the "AWS" folder**
```tasks
not done
path includes AWS
group by filename
```

**Example 2: Show tasks ONLY from the "Kubernetes" folder**
```tasks
not done
path includes Kubernetes
group by filename
```