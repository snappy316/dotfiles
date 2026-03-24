## macOS Settings

These require manual configuration (can't be scripted):

- Privacy & Security
  - System Settings > Privacy & Security
  - Full Disk Access — add Ghostty (primarily for Homebrew)
  - Local Network — add Arc (so it can access devices on the local network)
- Create 5 Mission Control desktops (the keyboard shortcuts are automated, but the desktops themselves must be created manually)

## 1Password

Get 1Password set up, so _things just work_.

- Log in
- Get Developer Mode set up
  - Set Up SSH Agent > let it "Edit Automatically"
    - Set up a new SSH key, and add the public key to GitHub — both as an "Authentication key" and as a "Signing key"
    - If desired, edit `~/.config/1Password/ssh/agent.toml` to restrict down to the new SSH key
    - Copy the public key string — you'll need it for the next step
  - Set up CLI integration
- Configure git identity (run from `~/.dotfiles`):
  ```
  ./profiles/common/install/gitconfig-local
  ```
  This will prompt for your email and the SSH signing key from 1Password.

## Raycast

Open Raycast, and get it configured.

## Work Environment

Copy machine-specific config from the old machine (both must be on the same network):

```bash
scp <user>@<old-machine>.local:~/.dotfiles/zsh/zshrc.local ~/.dotfiles/zsh/zshrc.local
```

This contains work-specific shell config (env vars, aliases, paths) that isn't checked into the repo.

## Claude Code Data Migration

If migrating from another machine, copy over Claude Code's persistent data. Most of `~/.claude/` regenerates automatically — only a few directories contain meaningful state.

### What to copy

| Directory/File | What it is | Size |
|---|---|---|
| `projects/` | Per-project CLAUDE.md files, memory, and settings | ~115 MB |
| `plugins/` | Installed plugins | ~10 MB |
| `skills/` | Custom user skills | tiny |
| `history.jsonl` | Command history | ~100 KB |

### What to skip

These regenerate on their own: `debug/`, `cache/`, `image-cache/`, `downloads/`, `statsig/`, `telemetry/`, `stats-cache.json`, `session-env/`, `sessions/`, `shell-snapshots/`, `plans/`, `tasks/`, `todos/`, `file-history/`, `backups/`, `policy-limits.json`.

`settings.json` is already managed by dotfiles (symlinked).

### On the old machine

```bash
tar czf claude-data.tar.gz -C ~/.claude projects plugins skills history.jsonl
```

Transfer to the new machine (both must be on the same network):

```bash
scp claude-data.tar.gz <user>@<new-machine>.local:~/
```

### On the new machine

```bash
# Make sure Claude Code has been run at least once so ~/.claude exists
tar xzf claude-data.tar.gz -C ~/.claude
```

### Verify

- `claude` — history should show previous commands (up arrow)
- Open a project that had a CLAUDE.md — it should be present
- `/skills` — custom skills should appear
