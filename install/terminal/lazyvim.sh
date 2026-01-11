#!/bin/zsh

# Backup existing nvim configuration if it exists
if [ -d ~/.config/nvim ]; then
    echo "Backing up existing nvim config..."
    mv ~/.config/nvim ~/.config/nvim.bak
fi

# optional but recommended - backup other nvim directories
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak


git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

# Copy custom configuration if it exists
if [ -d ~/.local/share/macdots/configs/neovim ]; then
    echo "Copying custom neovim configuration..."
    cp -R ~/.local/share/macdots/configs/neovim/* ~/.config/nvim/
fi
