# David's Dotfiles

We're now using [dotbot](https://github.com/anishathalye/dotbot)!

## Install

On a fresh macOS install, open a terminal, and run the following commands:

```
$ cd ~
$ git clone https://github.com/snappy316/dotfiles.git .dotfiles
$ cd .dotfiles
$ ./dev-install [work|personal]
```

Once it's done, restart the computer, then follow the instructions in [POST-INSTALL](POST-INSTALL.md).

(I'm still working on a single-command clone-and-install path, which uses the `./install` script...meaning `./dev-install` after manually cloning is the way to go for now.)

## Update

The install script is _meant_ to be idempotent...but in reality, there are always improvements to be made towards that. In general though, the same commands can be run to update things:

```
$ cd ~/.dotfiles
$ ./dev-install [work|personal]
```

If there's just a Homebrew update that's been made, run this:

```
$ brew bundle --file=profiles/common/Brewfile --no-upgrade
```
