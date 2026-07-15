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
- `#cicd/actions`
- `#cicd/jenkins`
- `#cicd/gitops` (PR-automation / GitOps tooling housed in CI-CD, e.g. Atlantis)
- `#agent-ai/fundamentals`
- `#agent-ai/langgraph`
- `#agent-ai/mcp`

## 2. Review Tag (Spaced Repetition)
- `#review` : This tag flags the entire note for the Spaced Repetition plugin so it will be periodically surfaced for reading.

## 3. Status Property (Frontmatter Only)
Used strictly as a YAML property `status:`, not as an inline tag. Valid values:
- `not-started`
- `in-progress`
- `completed`
