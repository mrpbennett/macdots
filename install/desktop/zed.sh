#!/bin/zsh

set -e

# Check if Zed is already installed
if [[ -d "/Applications/Zed.app" ]] || command -v zed >/dev/null 2>&1; then
    rm -rf ~/.config/zed
    cp -R ~/.local/share/macdots/configs/zed ~/.config/zed
fi
