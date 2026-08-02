# Cloud Engineering Vault Conventions

## 📂 Folder Structure
- **Knowledge Base**: Divided exclusively by high-level domain (`AWS`, `CI-CD`, `Infrastructure-as-Code`, `Kubernetes`, `Agentic-AI`). No deep nesting.
- **Templates**: Holds the master templates and taxonomy docs.
- **_attachments**: All images and media go here to prevent vault clutter.
- **Root**: `index.md` (Master Roadmap), `questions/` (Interview bank), `resume/` (Resume artifacts).

## 📄 Frontmatter Schema
Every note in the Knowledge Base MUST contain this YAML structure:
```yaml
---
tags:
  - [domain-tag]
  - review
status: [not-started | in-progress | completed]
Repetition: rep/1
---
```
- **Repetition Tracking (`Repetition:` property):** Every note must include a standalone `Repetition:` property in the frontmatter (`rep/1` through `rep/5` or `rep/mastered`) as a separate key-value pair—do NOT place it inside the `tags` array! This is required so that tracker base files and dashboards can view and filter study progress properly.

## 📝 Note Creation Rule
**EVERY** new concept note must be created using the `Templates/Master Concept Template.md`. Do not start blank files for core concepts. This ensures Zettelkasten linking blocks, spaced repetition flashcards, and Kanban statuses are always present.
