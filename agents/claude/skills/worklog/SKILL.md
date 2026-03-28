---
name: worklog
description: Update WORKLOG.md with a session summary. Use at the end of a session or at inflection points to capture what was explored, decided, changed, and what's next.
---

Update (or create) WORKLOG.md in the project root with a new session entry.

**Steps**

0. **Ensure project memory is committable** — before doing anything else, check whether this project's memory files live inside the repo. Run:
   ```
   ls -la ~/.claude/projects/<encoded-project-path>/memory
   ```
   where `<encoded-project-path>` is the current working directory with `/` replaced by `-` and leading `-` (e.g., `-Users-davidker-Projects-foo`).

   - **If it's already a symlink** → nothing to do, move on.
   - **If it's a real directory (or doesn't exist yet):**
     1. Create `.claude/memory/` in the project root (if it doesn't exist).
     2. Copy any existing files from `~/.claude/projects/<encoded-path>/memory/` into `<project>/.claude/memory/`.
     3. Remove the original directory: `rm -rf ~/.claude/projects/<encoded-path>/memory`
     4. Create the symlink: `ln -s <project-root>/.claude/memory ~/.claude/projects/<encoded-path>/memory`
     5. Tell the user: "Linked project memory into .claude/memory/ — these files are now committable with the project."

1. **Read existing WORKLOG.md** (if it exists) to understand the current state and avoid duplicate entries for today's date.

2. **Review the conversation** and draft a new entry using this format:

   ```markdown
   ## YYYY-MM-DD

   ### Session: <short descriptive title>

   **Explored:**
   <!-- Non-obvious findings, investigations, things we learned that aren't captured elsewhere -->

   **Changed:**
   <!-- What was created, modified, committed. Point to files/specs/PRs rather than restating their content. -->

   **Next:**
   <!-- What to pick up in the next session -->

   **Open Questions:**
   <!-- Optional. Unresolved decisions, things to verify during implementation, unknowns. Omit if none. -->
   ```

3. **Key principles:**
   - **Don't duplicate** — if something is documented in a spec, design doc, PR, or commit message, point to it with a brief summary instead of restating the details
   - **Capture the non-obvious** — the worklog's value is in the context, reasoning, and discoveries that aren't captured elsewhere
   - **Be concise** — this is a trail of breadcrumbs for picking up later, not a comprehensive record
   - **Reverse chronological** — newest entries at the top (just below the `# Worklog` header)

4. **Append the entry** to WORKLOG.md. If the file doesn't exist, create it with a `# Worklog` header.

5. **If multiple entries exist for the same date**, merge them under a single date header with separate session subsections.

6. **Check CLAUDE.md** — if the session introduced new patterns, tools, architectural decisions, or conventions that belong in CLAUDE.md, flag them to the user: "CLAUDE.md may need an update for: ..." Do NOT update CLAUDE.md automatically — just suggest.

**Output**

Show the user the new entry and ask if they'd like to adjust anything before moving on.
