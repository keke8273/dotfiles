#!/bin/bash

# Installation script for Ghostty terminal emulator (Ubuntu only)

echo "Checking if running on Ubuntu..."
if ! command -v apt > /dev/null 2>&1; then
    echo "Error: This script is for Ubuntu only (requires apt package manager)"
    exit 1
fi

# Check if ghostty is already installed
if command -v ghostty > /dev/null 2>&1; then
    echo "Ghostty is already installed"
    ghostty --version
else
    echo "Installing Ghostty..."

    # Add Ghostty PPA and install
    echo "Adding Ghostty PPA..."
    sudo add-apt-repository ppa:ghostty-org/ghostty -y

    echo "Updating package list..."
    sudo apt update

    echo "Installing Ghostty..."
    sudo apt install -y ghostty

    # Verify installation
    if command -v ghostty > /dev/null 2>&1; then
        echo "Ghostty installed successfully!"
        ghostty --version
    else
        echo "Error: Ghostty installation failed"
        exit 1
    fi
fi

echo "Setting up Ghostty configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create Ghostty config directory if it doesn't exist
mkdir -p ~/.config/ghostty

# Create symlink to config file
if [ -L ~/.config/ghostty/config ]; then
    echo "Removing existing symlink..."
    rm ~/.config/ghostty/config
elif [ -f ~/.config/ghostty/config ]; then
    echo "Backing up existing config file..."
    mv ~/.config/ghostty/config ~/.config/ghostty/config.backup
fi

echo "Creating symlink to Ghostty config..."
ln -s "$SCRIPT_DIR/config" ~/.config/ghostty/config
echo "Ghostty configuration linked successfully!"
