# Cloud Engineering Vault Conventions

## 📂 Folder Structure
- **Knowledge Base**: Divided exclusively by high-level domain (`AWS`, `CI-CD`, `Infrastructure-as-Code`, `Kubernetes`). No deep nesting.
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
---
```

## 📝 Note Creation Rule
**EVERY** new concept note must be created using the `Templates/Master Concept Template.md`. Do not start blank files for core concepts. This ensures Zettelkasten linking blocks, spaced repetition flashcards, and Kanban statuses are always present.
