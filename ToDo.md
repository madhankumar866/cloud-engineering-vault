- [x] collection Companies list in olympia, and update in notion to track ✅ 2026-07-30
- [ ] corss verify the olympia company manually
- [x] system design articles :

 - [ ] Write and publish LinkedIn post about Uber's Superuser Gateway pattern
- [ ] OOC revision
- [x] update todo list with tasks plugin ✅ 2026-07-30
- [x]  ✅ 2026-07-30
- [x] Update Revision mac ✅ 2026-07-30



TODO List

```tasks
not done
filename includes Todo.md
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