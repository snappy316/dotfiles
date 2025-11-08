## macOS Settings

The config script gets a bunch of stuff, but it doesn't do everything.

- Remap `caps lock` to `control`
  - System Settings > Keyboard > Keyboard Shortcuts > Keyboard > Modifier Keys > Caps Lock: Control
- It also doesn't get the multiple desktops - manually create them, then enable the shortcuts
  - System Settings > Keyboard > Keyboard Shortcuts > Keyboard > Mission Control > expand Mission Control > select all the "Switch to Desktop X" selectors
- Change power and screen saver settings
  - System Settings > Lock Screen
  - Start Screen Saver when inactive - 2:30
  - Turn display off on battery when inactive - 0:30
  - Turn display off on power adapter when inactive - 3:00
  - Require password after screen saver begins or display is turned off - 0:05

## 1Password

Get 1Password set up, so _things just work_.

- Log in
- Get Developer Mode set up
  - Set Up SSH Agent > let it "Edit Automatically"
    - Set up a new SSH key, and add the public key to GitHub - both as an "Authentication key" and as a "Signing key"
    - If desired, edit `~/.config/1Password/ssh/agent.toml` to restrict down to the new SSH key
    - Also add the GPG key to `.gitconfig.local`
  - Set up CLI integration

## Raycast

Open Raycast, and get it configured.
