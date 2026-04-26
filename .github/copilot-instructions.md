# Dotfiles Repository Guide

Personal dotfiles repository. Each tool lives in its own subdirectory with a config file and an installation script. Installation scripts deploy configs via **symlinks** back into this repo (not copies), so edits to the repo files take effect immediately.

## Tools Included

| Directory | Config target | Install script |
|---|---|---|
| `vim/` | `~/.vimrc` | `vim/01_install_vim.sh` |
| `zsh/` | `~/.zshrc`, `~/.p10k.zsh` | `zsh/01_install_zsh.sh` |
| `ghostty/` | `~/.config/ghostty/config` | `ghostty/01_install_ghostty.sh` |
| `vscode/` | VSCode + VSCodeVim extension | `vscode/01_install_vscode.sh` |
| `ai/copilot/` | `~/.copilot/mcp-config.json` | `ai/copilot/01_install.sh` |

## Installation Script Conventions

All scripts follow this pattern:

- `#!/bin/bash` shebang, named `01_install_*.sh`
- Idempotent — check state before making changes
- Use `command -v <tool> >/dev/null 2>&1` (not `which`) to test for programs
- Resolve script directory with `$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)` for portable relative paths
- Symlink check pattern: `if [ -L "$LINK" ] && [ "$(readlink "$LINK")" = "$SOURCE" ]` before calling `ln -sf`
- Package manager detection order: `apt` → `dnf`/`yum` → `pacman`; exit 1 if unsupported
- Echo status messages at each step

**Known deviations:**
- `vscode/01_install_vscode.sh` — Ubuntu/Debian only (no cross-distro detection)
- `ghostty/01_install_ghostty.sh` — Ubuntu only; removes existing symlink rather than using the idempotent check pattern
- `zsh/01_install_zsh.sh` — uses `set -e`; the `autojump` install is hardcoded to `apt` without distro detection

## Key Configuration Details

### Vim
- Plugin manager: `vim-plug` (`~/.vim/autoload/plug.vim`, plugins in `~/.vim/plugged/`)
- Plugins: vim-fugitive (git), vim-airline (status line), NERDTree (file explorer)
- 4-space indentation with `expandtab`; system clipboard integration enabled

### Zsh
- Framework: Oh My Zsh (`~/.oh-my-zsh/`)
- Theme: Powerlevel10k — reconfigure with `p10k configure`
- Third-party plugins installed to `${ZSH_CUSTOM}/plugins/`: `zsh-autosuggestions`, `zsh-syntax-highlighting`
- Keep the enabled plugin list minimal to preserve fast shell startup
- Git alias: `gs` = `git status`

### Ghostty
- Custom keybindings for split navigation (`ctrl+shift+←/→/↑/↓`) and close (`ctrl+shift+x`)
- Config syntax: `key = value` pairs; lines starting with `#` are comments

### AI / MCP
- `ai/copilot/mcp-config.json` — Copilot CLI MCP servers (AlphaVantage via `$API_KEY_ALPHAVANTAGE`, Notion)
- `ai/vscode/mcp-config.json` — VS Code MCP servers (AlphaVantage)
- `ai/skills/` — Custom Copilot CLI skills; each skill is a directory with a `SKILL.md`

## Commit Convention

Use conventional commits (see `ai/skills/git-commit/SKILL.md`):

```
type(scope): subject        # under 50 chars, imperative mood, no period
```

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `perf`, `ci`, `chore`  
Scopes map to tool directories: `vim`, `zsh`, `ghostty`, `vscode`, `ai`
