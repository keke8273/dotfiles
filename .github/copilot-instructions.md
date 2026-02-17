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

- **ai/** - AI assistant configurations and skills
  - `copilot/` - GitHub Copilot CLI MCP server configuration and installation
  - `vscode/` - VS Code MCP server configuration
  - `skills/` - Custom Copilot skills (e.g., git-commit for conventional commits)

## Installation Scripts

To set up these dotfiles on a new system, run the installation scripts:

```bash
# Install and configure Vim
./vim/01_install_vim.sh

# Install and configure Zsh
./zsh/01_install_zsh.sh

# Install Copilot MCP configuration (symlinks mcp-config.json to ~/.copilot/)
./ai/copilot/01_install.sh
```

All installation scripts follow these conventions:
- Named with `01_install_*.sh` prefix for easy discovery
- Idempotent (safe to run multiple times)
- Auto-detect the system's package manager (apt, yum, dnf, pacman)
- Exit with error code 1 if package manager is unsupported
- Use `command -v` for checking if programs exist
- Echo status messages for visibility

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

## Shell Script Conventions

When creating or modifying installation scripts:
- Use `#!/bin/bash` shebang
- Prefer `command -v` over `which` for program existence checks
- Output to `/dev/null 2>&1` for silent checks
- Use descriptive echo messages for user feedback
- Detect package manager with conditional `if command -v apt/dnf/pacman` blocks
- Exit with code 1 for unsupported package managers
- Keep scripts idempotent by checking state before making changes

## Development Notes

When updating configurations:
- Keep scripts idempotent (safe to run multiple times)
- Test package manager detection on target systems
- Maintain minimal plugin/plugin counts to prevent shell startup slowdown
- Document any new aliases or environment variables in zshrc comments
- Use conventional commit format (see `ai/skills/git-commit/SKILL.md`)
