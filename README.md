# Dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/josayko/Dotconfigs.git
$ cd Dotconfigs
```

then use GNU stow to create symlinks

```
$ stow .
```

## Uninstallation
Remove created symlinks
```
$ stow -D .
```
