# Tag Taxonomy

This vault uses a strict three-namespace taxonomy to maintain order:

## 1. Topic Tags (Domain classification)
Used to group related concepts. Every note must have at least one topic tag.
- `#aws/networking`
- `#aws/compute`
- `#aws/security`
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

## 5. Repetition State Tags
Used to track where a note is in the memorization schedule. Add one of these to the frontmatter `tags` array:
- `#rep/1` : Needs 1st Repetition (In-Class / Active Capture)
- `#rep/2` : Needs 2nd Repetition (Out-of-Class / Synthesis)
- `#rep/3` : Needs 3rd Repetition (Next day / 1-day)
- `#rep/4` : Needs 4th Repetition (2-3 weeks)
- `#rep/5` : Needs 5th Repetition (2-3 months)
- `#rep/mastered` : Schedule complete
