# Dotfiles Improvement Ideas

## Big Opportunities

- [x] **Claude Code data migration** — Documented in POST-INSTALL.md (tar/untar of projects, plugins, skills, history).
- [x] **Automate POST-INSTALL.md manual steps** — Caps Lock remap, Mission Control shortcuts, etc. via `defaults write` in the macOS install script.

## Quick Wins

- [x] **Automate `.gitconfig.local` creation** — Prompt for signing key during install, or pull from 1Password CLI.
- [x] **Mac App Store apps via `mas`** — `mas` is in the Brewfile but no actual apps are listed.
- [x] **TouchID for `sudo`** — Enable `pam_tid.so` so `sudo` prompts use TouchID instead of a password.

## Nice-to-Haves

- [x] **Dock configuration** — Already handled: dock is wiped and auto-hidden by the macOS script.
- [ ] **Neovim headless plugin install** — `nvim --headless "+Lazy! sync" +qa` as a post-install step.
- [ ] **Health check / doctor script** — Verify links, tools, and versions are correct.
- [ ] **Brew wrapper script** — Simplify `brew bundle` usage with profile awareness and package management.
- [x] **Fully lean on 1Password for SSH + GPG** — Stop using local keys entirely.

---

## Sketches

### Doctor script (`./doctor`)

Verifies the dotfiles setup is healthy. Run anytime to diagnose issues.

**Checks:**
- All dotbot symlinks are intact (not broken)
- Expected tools on PATH: `brew`, `git`, `node`, `npm`, `tmux`, `nvim`, `op`, `gh`, `lazygit`
- `~/.dotfiles/git/.gitconfig.local` exists and has `signingkey`
- `~/.config/1Password/ssh/agent.toml` exists
- 1Password SSH agent is reachable (`ssh-add -l` returns keys)
- TouchID for sudo is configured (`pam_tid` in `/etc/pam.d/sudo_local`)
- `pam_reattach` is present (for tmux)
- Oh My Zsh installed at `~/.oh-my-zsh`
- Oh My Zsh plugins installed (syntax-highlighting, autosuggestions)
- TPM installed at `~/.tmux/plugins/tpm`
- Caps Lock → Control remap is active (`hidutil property --get UserKeyMapping`)

**Output:** Green checkmarks for passing, red X for failures with fix suggestions.

### Brew wrapper (`./brew`)

Profile-aware brew bundle wrapper.

**Usage:**
```
./brew [profile]                      # brew bundle for common + profile (default: work)
./brew [profile] add [type] [name]    # add package to profile's Brewfile and install
```

**Examples:**
```
./brew                        # brew bundle common + work (no upgrade)
./brew personal               # brew bundle common + personal (no upgrade)
./brew work add cask discord  # appends `cask "discord"` to work Brewfile, installs
./brew common add brew jq     # appends `brew "jq"` to common Brewfile, installs
./brew add mas "App" 123456   # shorthand for work profile
```

**Behavior:**
- `add` appends the correct line to the right Brewfile, then runs `brew bundle` for that file
- Profile defaults to `work` if omitted
- Always passes `--no-upgrade`
