## Task Hub & Apple Sync Test (August 5)
- [x] Test Task Hub list view & Apple Reminders integration 📅 2026-08-05 ⏰ 18:30 #agent-ai ✅ 2026-08-05
- [x] Drag-and-drop reschedule test in Task Hub Calendar 🛫 2026-08-05 📅 2026-08-06 #aws/networking ✅ 2026-08-05
- [x] Review Apple Calendar meetings alongside study schedule 📅 2026-08-05 ✅ 2026-08-05

## August 6

- [ ] Set up one-way sync from this todo file to Notion using the local sync script
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

## 📅 Spaced Repetition Schedule (Active Review Dates)
```dataview
TABLE Repetition AS "Current Stage", row["Next-Review"] AS "Review Date"
FROM "Knowledge Base"
WHERE row["Next-Review"] != null AND row["Next-Review"] != "" AND Repetition != "rep/mastered"
SORT row["Next-Review"] ASC
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