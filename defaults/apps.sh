#!/bin/zsh

# Moving all files from config to .config app directory

# --- SET UP LAZYVIM IDE ---
# remove homebrews default nvim install
rm -rf ~/.config/nvim.bak
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# copy my lazyvim config
cp -R ~/.local/share/macdots/configs/nvim ~/.config/nvim
