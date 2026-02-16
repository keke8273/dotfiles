#!/bin/bash

# Exit on errors
set -e

echo "Updating package list..."
# For Debian/Ubuntu
if command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y zsh curl git
# For RedHat/CentOS/Fedora
elif command -v yum &>/dev/null; then
    sudo yum install -y zsh curl git
elif command -v dnf &>/dev/null; then
    sudo dnf install -y zsh curl git
else
    echo "Unsupported package manager. Install zsh manually."
    exit 1
fi

# Make zsh the default shell for the current user
if ! grep -q "$(which zsh)" /etc/shells; then
    echo "Adding zsh to /etc/shells"
    echo "$(which zsh)" | sudo tee -a /etc/shells
fi

# Check if zsh is already the default shell
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
if [ "$CURRENT_SHELL" = "$(which zsh)" ]; then
    echo "Zsh is already the default shell for user $USER"
else
    echo "Changing default shell to zsh for user $USER"
    chsh -s "$(which zsh)" "$USER"
fi

# Install Oh My Zsh (non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# Define Powerlevel10k theme path
P10K_PATH="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install Powerlevel10k if not installed
if [ ! -d "$P10K_PATH" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_PATH"
else
    echo "Powerlevel10k already installed."
fi

# Define zsh-autosuggestions plugin path
AUTOSUGGESTIONS_PATH="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# Install zsh-autosuggestions if not installed
if [ ! -d "$AUTOSUGGESTIONS_PATH" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_PATH"
else
    echo "zsh-autosuggestions already installed."
fi

# -------------------------------
# Create symlinks for zshrc and p10k.zsh
# -------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SOURCE="$SCRIPT_DIR/zshrc"
ZSHRC_LINK="$HOME/.zshrc"
if [ -L "$ZSHRC_LINK" ] && [ "$(readlink "$ZSHRC_LINK")" = "$ZSHRC_SOURCE" ]; then
    echo ".zshrc symlink already points to the correct location."
else
    ln -sf "$ZSHRC_SOURCE" "$ZSHRC_LINK"
    echo "Created symlink: $ZSHRC_LINK -> $ZSHRC_SOURCE"
fi

P10K_SOURCE="$SCRIPT_DIR/p10k.zsh"
P10K_LINK="$HOME/.p10k.zsh"
if [ -L "$P10K_LINK" ] && [ "$(readlink "$P10K_LINK")" = "$P10K_SOURCE" ]; then
    echo ".p10k.zsh symlink already points to the correct location."
else
    ln -sf "$P10K_SOURCE" "$P10K_LINK"
    echo "Created symlink: $P10K_LINK -> $P10K_SOURCE"
fi

echo "Zsh installation and setup complete!"
echo "Please log out and log back in (or restart terminal) to start using Zsh."

