# Inbox Manager Sub-Agent Instructions

When the user asks to "process the inbox", you must spawn a separate sub-agent using the `invoke_subagent` tool with the role `Inbox Manager`. Give the sub-agent the following instructions in its prompt:

## Inbox Manager Responsibilities (The Capture, Process, Act Framework)

You are responsible for triaging the user's links from a passive bookmark list into an actionable tech laboratory.

### 1. Read & Triage the Inbox
- Open `Inbox/Inbox.md`. Look for unchecked items under the `### 📝 To Process` heading.
- **Investigate:** DO NOT assume the topic based purely on the URL or title. If possible, quickly research or fetch the URL content to understand its core purpose.
- **Filter (The 3 Decisions):**
  - *Trash:* If the link is irrelevant hype, delete it.
  - *Archive/Read Later:* If it's just a long conceptual blog, move it to a reading list.
  - *Actionable:* If it's a new tool, architecture pattern, or technology to test, proceed to Step 2.

### 2. Move to the Action Tracker (Create Tech Notes)
For every *Actionable* item:
- Create a new Markdown file in the `Inbox/02_Tech_Lab/` folder.
- Name the file after the tool or concept (e.g., `Inbox/02_Tech_Lab/Argo Workflows.md`).
- Populate the file using the exact structure found in `Inbox/Templates/Tech Note Template.md`. 
- **CRITICAL - YOU MUST FILL IN THE TEMPLATE:** Because the user is entirely new to the topics, you must do the heavy lifting of preparing their study session. You must completely overwrite the template placeholders with actual content:
  - **The Elevator Pitch:** Write a clear 2-sentence summary of what it is.
  - **Why It Matters:** Explain exactly why the user should care based on their Cloud Engineering / AI goals.
  - **The 30-Minute Spike:** Replace the generic checkboxes with 3-4 specific, customized steps for them to run a hands-on "Hello World". 
  - **Key Snippets & Takeaways:** Provide an actual, working code block or configuration YAML.
  - **HARDWARE CONTEXT (CRITICAL):** The user is on a **MacBook Air M4 (Apple Silicon)**. Ensure all installation commands, Docker images (e.g., use ARM64 images), and AI code snippets (e.g., use `device="mps"` in PyTorch instead of `cuda`) are specifically tailored for macOS Apple Silicon and unified memory constraints.
- Leave the `status` as `⏳ Backlog`. Dataview will automatically pick this up on the `Tech Tracking Dashboard`.

### 3. Update the Visual Architecture (Canvas)
Open `Inbox/Inbox Canvas.canvas` to map out the new tools spatially.
- **Non-Destructive Append:** Do NOT overwrite existing nodes or wipe the canvas. Read the existing JSON, and only *add* your new nodes/edges to the arrays. Expand the width/height of existing `group` nodes if you are adding new items inside them.
- **Determine Logical Order:** Categorize each new resource into a logical progression (e.g., `Foundations & Architecture` -> `Model Optimization` -> `Infrastructure & Tooling`). If adding to an existing group, sort the items logically or chronologically within that box.
- **Add Nodes:** Add a new `"type": "text"` node for the resource. **CRITICAL RULE:** Following the vault's GEMINI.md rules, do NOT use `"type": "file"` to embed the markdown file. Instead, use a text node with an Obsidian wikilink formatting it as a button: `### [[Note Name]]`.
- **Cluster & Connect:** Use Canvas `"group"` nodes to visually bundle related topics together. Arrange new groups cleanly (e.g., below or to the right of existing groups) so they do not overlap. Draw an edge (arrow) between nodes if one directly builds upon another.

### 4. Mark as Processed
Once the tech notes are created and the canvas is updated:
- Edit `Inbox/Inbox.md`.
- Move the processed items to the `### ✅ Processed` section.
- Mark their checkboxes as `[x]`.
- **Report Back:** Inform the parent agent when the inbox has been successfully processed, detailing the new notes created in `Inbox/02_Tech_Lab`.

### Canvas JSON Requirements
When writing to `.canvas` files, ensure your JSON is perfectly valid. Do not use Markdown file embeds (`"type": "file"`). Use `"type": "text"` and put the links inside the `text` property, following the Vault's established Canvas rules.
