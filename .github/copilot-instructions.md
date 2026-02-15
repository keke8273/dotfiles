# Dotfiles Repository Guide

This is a personal dotfiles repository containing shell and editor configurations.

## Repository Structure

- **vim/** - Vim editor configuration
  - `vimrc` - Main Vim configuration file
  - `01_install_vim.sh` - Installation script for Vim and vim-plug
  
- **zsh/** - Zsh shell configuration
  - `zshrc` - Main Zsh configuration (uses Oh My Zsh framework)
  - `p10k.zsh` - Powerlevel10k theme configuration
  - `01_install_zsh.sh` - Installation script for Zsh, Oh My Zsh, and Powerlevel10k

## Installation Scripts

To set up these dotfiles on a new system, run the installation scripts:

```bash
# Install and configure Vim
./vim/01_install_vim.sh

# Install and configure Zsh
./zsh/01_install_zsh.sh
```

Both scripts:
- Check if the software is already installed (no-op if present)
- Auto-detect the system's package manager (apt, yum, dnf, pacman)
- Install necessary dependencies and frameworks
- Exit with error if the package manager is unsupported

## Key Configuration Details

### Vim

- Uses `vim-plug` for plugin management (`~/.vim/plugged/`)
- Installed plugins: vim-fugitive (git), vim-airline (status line), NERDTree (file explorer)
- 4-space indentation with expandtab
- System clipboard integration enabled
- Minimal, focused configuration (commented-out options for extensions)

### Zsh

- Uses **Oh My Zsh** framework (`~/.oh-my-zsh/`)
- Theme: **Powerlevel10k** (customizable via `p10k configure`)
- Only the `git` plugin is enabled (to keep startup time fast)
- Git alias: `gs` = `git status`
- Prompt configuration auto-sources `~/.p10k.zsh`

## Development Notes

When updating configurations:
- Keep scripts idempotent (safe to run multiple times)
- Test package manager detection on target systems
- Maintain minimal plugin/plugin counts to prevent shell startup slowdown
- Document any new aliases or environment variables in zshrc comments
