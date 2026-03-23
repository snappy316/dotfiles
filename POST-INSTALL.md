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
    - The signing key will be added to `.gitconfig.local` during `./install` — have the public key string ready
  - Set up CLI integration

## Raycast

Open Raycast, and get it configured.
