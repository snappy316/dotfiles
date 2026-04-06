---
name: create-pr
description: Create a GitHub pull request with a narrative description. Use when the user asks to open/create a PR or says /create-pr.
---

Create a GitHub pull request for the current branch.

**Principles**

- **Title** — short, clear summary of the purpose of the PR. Under 72 characters.
- **Narrative over bullet points** — describe the changes in prose, not lists. The commits and diff show *what* changed; the PR description explains *what* and *why* at a higher level.
- **Keep it concise** — a few sentences is usually enough. Don't restate the diff.

**Template**

Use only the **What** and **Why** sections:

```markdown
## What

A brief narrative explanation of what this PR does.

## Why

The motivation, context, or problem that led to these changes.
```

Omit the How, Notes, and Screenshots sections unless the user specifically asks for them or the changes genuinely warrant it (e.g., a UI change where a screenshot helps).

End the body with:
```
🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

**Steps**

1. Run `git status` to check for uncommitted changes. If there are unstaged changes, ask the user if they want to commit first.
2. Run `git log` and `git diff main...HEAD` (or the appropriate base branch) to understand the full set of changes on the branch.
3. Check if the branch has been pushed to remote. If not, push with `-u`.
4. Draft the PR title and body, then create it with `gh pr create`.
5. Return the PR URL to the user.

**Do NOT**

- Add a test plan section
- Use bullet-point lists of changes
- Include the Co-Authored-By line in the PR body (that's for commits only)
