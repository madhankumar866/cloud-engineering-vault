# Tag Taxonomy

This vault uses a strict three-namespace taxonomy to maintain order:

## 1. Topic Tags (Domain classification)
Used to group related concepts. Every note must have at least one topic tag.
- `#aws/networking`
- `#aws/compute`
- `#aws/security`
- `#kubernetes/core`
- `#kubernetes/security`
- `#kubernetes/networking`
- `#kubernetes/storage`
- `#kubernetes/eks`
- `#kubernetes/gitops`
- `#iac/terraform`
- `#iac/terragrunt`
- `#cicd/actions`
- `#cicd/jenkins`
- `#cicd/gitops` (PR-automation / GitOps tooling housed in CI-CD, e.g. Atlantis)
- `#agent-ai/fundamentals`
- `#agent-ai/langgraph`
- `#agent-ai/mcp`
- `#system-design`

## 2. Review Tag (Spaced Repetition)
- `#review` : This tag flags the entire note for the Spaced Repetition plugin so it will be periodically surfaced for reading.

## 3. Flashcard Namespace Tags
Domain-namespaced for spaced repetition:
- `#flashcards/aws`
- `#flashcards/iac`
- `#flashcards/kubernetes`
- `#flashcards/cicd`
- `#flashcards/agent-ai`

## 4. Status Property (Frontmatter Only)
Used strictly as a YAML property `status:`, not as an inline tag. Valid values:
- `not-started`
- `in-progress`
- `completed`

## 5. Repetition State Property (`Repetition:`)
Used to track where a note is in the memorization schedule. Add this as a standalone key-value property in the YAML frontmatter (e.g., `Repetition: rep/1`)—never inside the `tags:` array, so that tracker base files and dashboards can query study progress properly:
- `Repetition: rep/1` : Needs 1st Repetition (In-Class / Active Capture)
- `Repetition: rep/2` : Needs 2nd Repetition (Out-of-Class / Synthesis)
- `Repetition: rep/3` : Needs 3rd Repetition (Next day / 1-day)
- `Repetition: rep/4` : Needs 4th Repetition (2-3 weeks)
- `Repetition: rep/5` : Needs 5th Repetition (2-3 months)
- `Repetition: rep/mastered` : Schedule complete
