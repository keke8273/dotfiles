#!/bin/bash

# -------------------------------
# Install Vim if missing
# -------------------------------
if ! command -v vim >/dev/null 2>&1; then
    echo "Vim not found. Installing Vim..."
    
    # Detect package manager
    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y vim
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y vim
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm vim
    else
        echo "Unsupported package manager. Install Vim manually."
        exit 1
    fi
else
    echo "Vim is already installed."
fi

# -------------------------------
# Install vim-plug if missing
# -------------------------------
VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$VIM_PLUG_PATH" ]; then
    echo "vim-plug not found. Installing vim-plug..."
    curl -fLo "$VIM_PLUG_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug is already installed."
fi

echo "Done!"

