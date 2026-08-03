# Tracking Repetitions in Obsidian

You use **Repetition State Properties** and **Next-Review Dates** in the YAML frontmatter to track where you are in the memorization schedule and surface notes directly inside your tracker base file and Dataview dashboards.

## 1. Frontmatter Schema & Lifecycle Rules
Whenever you create or study a note, ensure both standalone frontmatter properties `Repetition: rep/X` and `Next-Review:` are present (never place repetition status inside the `tags:` array, as tracker dashboards rely on the independent property fields):

```yaml
---
tags:
  - iac/terraform
  - review
status: not-started
Repetition: rep/1
Next-Review: 
---
```

### 🚨 Critical Completion Validation Rule
- **Incomplete Topics (`status: not-started` | `in-progress`):** The `Next-Review:` property must remain **empty/blank**. Do not fill in revision dates for topics that haven't finished their initial learning phase.
- **Completed Topics (`status: completed`):** Whenever a topic's status is moved to `completed`, you (and AI assistants) MUST validate and fill in `Next-Review: YYYY-MM-DD` with a date calculated from the exact date when the topic was moved to `completed`.

---

## 2. 📅 Stage & Date Calculation Ratios (from Completion Date):
- `Repetition: rep/1` or `rep/2` : **Needs 1st/2nd Repetition** (Active Capture & Synthesis) → **Set `Next-Review: <Completion Date>`** (Day 0)
- `Repetition: rep/3` : **Needs 3rd Repetition** (Next-day check) → **Set `Next-Review: +1 Day from completion date`**
- `Repetition: rep/4` : **Needs 4th Repetition** (2-week review) → **Set `Next-Review: +14 Days from completion date`**
- `Repetition: rep/5` : **Needs 5th Repetition** (2-month review) → **Set `Next-Review: +60 Days from completion date`**
- `Repetition: rep/mastered` : **Schedule Complete!** → Remove date or leave `Next-Review:` empty.

---

## 3. How to use them in daily practice
1. When you start learning a new topic using `Master Concept Template`, `Repetition: rep/1` and an empty `Next-Review:` are automatically present in the frontmatter.
2. Complete your fast, symbolic notes and out-of-class synthesis without setting a revision date while in-progress.
3. As soon as you complete the learning and mark `status: completed`, set your initial `Next-Review` date based on the timestamp of completion.
4. When your automated **"🔔 Topics Due for Review Today"** dashboard in `Todo.md` surfaces the note on a due date, review the flashcards/mind map, bump the stage (e.g. `rep/3` → `rep/4`), and advance the `Next-Review` date according to the schedule interval!
