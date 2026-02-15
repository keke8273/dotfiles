# Dotfiles

A personal dotfiles repository containing automated setup for Vim and Zsh shell environments.

## Overview

This repository provides:
- **Minimal, focused configurations** for Vim and Zsh that prioritize performance and usability
- **Automated installation scripts** that detect your system's package manager and set up everything in one command
- **Cross-platform support** for Debian/Ubuntu, RedHat/CentOS/Fedora, and Arch systems

## Quick Start

Clone this repository and run the installation scripts:

```bash
./vim/01_install_vim.sh      # Sets up Vim with vim-plug and core plugins
./zsh/01_install_zsh.sh      # Sets up Zsh with Oh My Zsh and Powerlevel10k
```

Both scripts are idempotent—safe to run multiple times.

## What's Included

- **Vim** - Minimal vimrc with vim-fugitive, vim-airline, and NERDTree
- **Zsh** - Oh My Zsh configuration with Powerlevel10k theme and optimized plugins for speed

For detailed configuration notes, see [.github/copilot-instructions.md](.github/copilot-instructions.md).
