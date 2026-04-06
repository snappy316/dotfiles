---
name: commit
description: Create focused, well-crafted git commits. Use when the user asks to commit changes or says /commit.
---

Create one or more focused git commits from the current staged/unstaged changes.

**Principles**

- **Atomic commits** — each commit should represent one logical change. If the working tree contains multiple unrelated changes, split them into separate commits. Ask the user if the grouping is unclear.
- **Subject line** — keep it under 72 characters. Short summary of *what* changed, written in imperative mood (e.g., "Add retry logic to upload handler").
- **Body** — explain *why* the change was made, not *what* changed (the diff shows that). Provide context that someone reading `git log` in six months would find useful: motivation, trade-offs, things that were considered and rejected.
- **No conventional commit prefixes** — don't use `feat:`, `fix:`, `chore:`, etc.
- **Co-author line** — end every commit message with:
  ```
  Co-Authored-By: Claude <co-authored-by@anthropic.com>
  ```

**Steps**

1. Run `git status` and `git diff` (staged + unstaged) to understand all current changes.
2. Run `git log --oneline -5` to see recent commit style for reference.
3. Analyze the changes and propose a grouping into atomic commits. If there's only one logical change, proceed directly. If there are multiple, show the user the proposed breakdown and get confirmation before committing.
4. For each commit:
   - Stage only the relevant files (`git add <specific files>`, never `git add -A` or `git add .`)
   - Commit with a subject + body using a HEREDOC for formatting
5. Run `git status` after all commits to confirm everything is clean (or show what remains uncommitted).

**Do NOT**

- Push to remote unless explicitly asked
- Amend existing commits unless explicitly asked
- Skip pre-commit hooks
- Stage files that look like secrets (.env, credentials, tokens)
