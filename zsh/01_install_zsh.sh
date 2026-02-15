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

echo "Changing default shell to zsh for user $USER"
chsh -s "$(which zsh)" "$USER"

# Install Oh My Zsh (non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

echo "Zsh installation and setup complete!"
echo "Please log out and log back in (or restart terminal) to start using Zsh."

