#!/bin/zsh

set -e

if command -v ghostty >/dev/null 2>&1; then
    rm -rf ~/.config/ghostty
    cp -R ~/.local/share/macdots/configs/ghostty ~/.config/ghostty
fi
