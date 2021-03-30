# David's dotfiles

Originally these were heavily inspired by [Ryan's config files](https://github.com/ryansobol/config/) and the [Ruby Foundations class setup files](https://github.com/codefellows/sea-c21-ruby/tree/master/lib/class1/osx). Since then, they've taken on a life of their own.

## dotfiles

Most of the dotfiles are shared across Linux and MacOS, but there are a handful of differences.

### Common dotfiles

### Linux-only
- `.gitconfig` uses ???
- `.zshrc` uses the `nerdfont-patched` Powerlevel9k theme, because that's what BlinkSH supports easier

### MacOS-only
- `.gitconfig` uses the `osxkeychain`
- `.zshrc` uses the `awesome-patched` Powerlevel9k theme


## Install

Run `./dev-install` on either Linux or MacOS to bootstrap a Rails / JS dev environment setup. The script will automatically detect the OS, and run the proper script for each environment.

### Common programs
- zsh
- oh-my-zsh
- rbenv
- git
- tmux
- Node.js
- postgres
- mysql
- redis
- openssl

### Linux-only
- curl versions of the common programs

### MacOS-only
- Homebrew versions of the common programs
