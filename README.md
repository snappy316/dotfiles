# David's Dotfiles

We're now using [dotbot](https://github.com/anishathalye/dotbot)!

## Fresh Install

On a fresh macOS install, open a terminal and run:

```
curl -fsSL https://raw.githubusercontent.com/snappy316/dotfiles/main/install | bash
```

Or, to skip the profile prompt:

```
curl -fsSL https://raw.githubusercontent.com/snappy316/dotfiles/main/install | bash -s work
```

Once it's done, restart the computer, then follow the instructions in [POST-INSTALL](POST-INSTALL.md).

## Re-run / Update

```
cd ~/.dotfiles
./install [work|personal]
```

If there's just a Homebrew update that's been made, run this:

```
brew bundle --file=profiles/common/Brewfile --no-upgrade
```
