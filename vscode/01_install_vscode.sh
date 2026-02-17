#!/bin/bash

# Check if VSCode is already installed
if command -v code > /dev/null 2>&1; then
    echo "VSCode is already installed."
else
    echo "VSCode not found. Installing VSCode..."

    # Check for apt package manager (Ubuntu/Debian)
    if ! command -v apt > /dev/null 2>&1; then
        echo "Error: Unsupported package manager. This script only supports Ubuntu/Debian systems."
        exit 1
    fi

    echo "Installing VSCode on Ubuntu/Debian..."
    sudo apt update
    sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code

    # Verify installation
    if ! command -v code > /dev/null 2>&1; then
        echo "Error: VSCode installation failed."
        exit 1
    fi
    echo "VSCode installed successfully!"
fi

# Install VSCodeVim extension
echo "Installing VSCodeVim extension..."
code --install-extension vscodevim.vim
echo "VSCodeVim extension installed!"
