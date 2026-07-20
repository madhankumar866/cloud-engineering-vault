# Tech Tracking Dashboard

### 🚀 Active Testing (In Progress)
```dataview
TABLE category AS Category, source_url AS Link
FROM "Inbox/02_Tech_Lab"
WHERE type = "tech-triage" AND status = "🏃 In Progress"
```

### ⏳ The Backlog (To Be Processed)
```dataview
TABLE category AS Category, date_saved AS "Saved On"
FROM "Inbox/02_Tech_Lab"
WHERE type = "tech-triage" AND status = "⏳ Backlog"
```
